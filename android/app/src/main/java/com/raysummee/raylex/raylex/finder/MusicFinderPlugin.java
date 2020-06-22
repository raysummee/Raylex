package com.raysummee.raylex.raylex.finder;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.os.Process;

import androidx.annotation.NonNull;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class MusicFinderPlugin implements MethodChannel.MethodCallHandler,PluginRegistry.RequestPermissionsResultListener {
    private static final int REQUEST_CODE_STORAGE_PERMISSION = 3777;
    private Activity activity;
    private Map<String, Object> arguments;
    private boolean executeAfterPermissionGranted;
    private MethodChannel.Result pendingResult;
    private MethodChannel channel;
    private static MusicFinderPlugin instance;

    public static void registerWith(PluginRegistry.Registrar registrar){
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.Raysummee.raylex/finder");
        instance = new MusicFinderPlugin(registrar.activity(), channel);
        registrar.addRequestPermissionsResultListener(instance);
        channel.setMethodCallHandler(instance);
    }

    public MusicFinderPlugin(Activity activity, MethodChannel channel) {
        this.activity = activity;
        this.channel = channel;
        this.channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("getSongs")) {
            pendingResult = result;
            if (!(call.arguments instanceof Map)) {
                throw new IllegalArgumentException("Plugin not passing a map as parameter: " + call.arguments);
            }
            arguments = (Map<String, Object>) call.arguments;
            boolean handlePermission = (boolean) arguments.get("handlePermissions");
            this.executeAfterPermissionGranted = (boolean) arguments.get("executeAfterPermissionGranted");
            checkPermission(handlePermission);
            // result.success(getData());
        }
    }

    private void checkPermission(boolean handlePermission) {
        if (checkSelfPermission(activity, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            if (shouldShowRequestPermissionRationale(activity, Manifest.permission.READ_EXTERNAL_STORAGE)) {
                // TODO: user should be explained why the app needs the permission
                if (handlePermission) {
                    requestPermissions();
                } else {
                    setNoPermissionsError();
                }
            } else {
                if (handlePermission) {
                    requestPermissions();
                } else {
                    setNoPermissionsError();
                }
            }

        } else {
            pendingResult.success(getData());
            pendingResult = null;
            arguments = null;
        }
    }

    private void scanMusicFiles(File[] files) {
        for (File file: files) {
            if (file.isDirectory())  {
                scanMusicFiles(file.listFiles());
            } else {
                activity.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.parse("file://"
                        + file.getAbsolutePath())));
            }
        }
    }

    ArrayList<HashMap> getData() {
        MusicFinder mf = new MusicFinder(activity.getContentResolver());

        // Scan all files under Music folder in external storage directory
        scanMusicFiles(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_MUSIC).listFiles());

        mf.prepare();
        List<MusicFinder.Song> allsongs = mf.getAllSongs();
        ArrayList<HashMap> songsMap = new ArrayList<>();
        for (MusicFinder.Song s : allsongs) {
            songsMap.add(s.toMap());
        }
        return songsMap;
    }

    @TargetApi(Build.VERSION_CODES.M)
    private void requestPermissions() {
        activity.requestPermissions(new String[] { Manifest.permission.READ_EXTERNAL_STORAGE },
                REQUEST_CODE_STORAGE_PERMISSION);
    }

    private boolean shouldShowRequestPermissionRationale(Activity activity, String permission) {
        if (Build.VERSION.SDK_INT >= 23) {
            return activity.shouldShowRequestPermissionRationale(permission);
        }
        return false;
    }

    private int checkSelfPermission(Context context, String permission) {
        if (permission == null) {
            throw new IllegalArgumentException("permission is null");
        }
        return context.checkPermission(permission, android.os.Process.myPid(), Process.myUid());
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        Log.e("permission","started");

        if (requestCode == REQUEST_CODE_STORAGE_PERMISSION) {
            for (int i = 0; i < permissions.length; i++) {
                String permission = permissions[i];
                int grantResult = grantResults[i];

                if (permission.equals(Manifest.permission.READ_EXTERNAL_STORAGE)) {
                    if (grantResult == PackageManager.PERMISSION_GRANTED) {
                        Log.e("permission","granted");
                        if (executeAfterPermissionGranted) {
                            Log.e("permisson","executing");
                            pendingResult.success(getData());
                            pendingResult = null;
                            arguments = null;
                        }
                    } else {
                        setNoPermissionsError();
                    }
                }
            }
        }
        return false;
    }

    private void setNoPermissionsError() {
        pendingResult.error("permission", "you don't have the user permission to access the storage", null);
        pendingResult = null;
        arguments = null;
    }




}
