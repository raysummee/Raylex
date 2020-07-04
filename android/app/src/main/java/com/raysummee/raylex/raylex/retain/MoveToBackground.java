package com.raysummee.raylex.raylex.retain;

import android.content.Context;

import androidx.annotation.NonNull;

import com.raysummee.raylex.raylex.player.PlayerController;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class MoveToBackground implements MethodChannel.MethodCallHandler {
    Context context;
    MethodChannel channel;
    static MoveToBackground instance;
    public MoveToBackground(Context context, MethodChannel channel){
        this.context = context;
        this.channel = channel;
    }

    public static void registerWith(PluginRegistry.Registrar registrar){
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "com.Raysummee.raylex/audio");
        instance = new MoveToBackground(registrar.activity(), channel);
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method){

        }
    }
}
