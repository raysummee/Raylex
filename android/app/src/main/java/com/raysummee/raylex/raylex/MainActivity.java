package com.raysummee.raylex.raylex;

import android.os.Bundle;

import androidx.annotation.NonNull;

import com.raysummee.raylex.raylex.finder.MusicFinderPlugin;
import com.raysummee.raylex.raylex.player.PlayerController;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.android.FlutterEngineProvider;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class MainActivity extends FlutterActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        PlayerController.registerWith(registrarFor("com.Raysummee.raylex/audio"));
        MusicFinderPlugin.registerWith(registrarFor("com.Raysummee.raylex/finder"));
        com.tekartik.sqflite.SqflitePlugin.registerWith(registrarFor("com.tekartik.sqflite"));
        new MethodChannel(getFlutterView(), "com.Raysummee.raylex/androidRetain").setMethodCallHandler(
                (call, result) -> {
                    if(call.method.equals("sendToBackground")){
                        moveTaskToBack(true);
                    }
                }
        );

    }

}
