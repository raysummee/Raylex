package com.raysummee.raylex.raylex;

import android.os.Bundle;

import com.raysummee.raylex.raylex.finder.MusicFinderPlugin;
import com.raysummee.raylex.raylex.player.PlayerController;

import io.flutter.app.FlutterActivity;
import io.flutter.embedding.android.FlutterEngineProvider;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class MainActivity extends FlutterActivity {
    private static final String CHANNELPLAYER = "com.Raysummee.raylex/audio";
    private static final String CHANNELFINDER = "com.Raysummee.raylex/finder";

    private MethodChannel channelPlayer;
    private MethodChannel channelFinder;
    private PlayerController playerController;
    private MusicFinderPlugin musicFinderPlugin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        channelPlayer = new MethodChannel(getFlutterView(), CHANNELPLAYER);
        playerController = new PlayerController(this, channelPlayer);
        channelFinder = new MethodChannel(getFlutterView(), CHANNELFINDER);
        musicFinderPlugin = new MusicFinderPlugin(this, channelFinder);
        channelPlayer.setMethodCallHandler(
            (call, result) -> {
                switch (call.method){
                        case "playMusic":
                            playerController.playMusic(call.argument("url"));
                            break;
                        case "pauseMusic":
                            playerController.pauseMusic();
                            break;
                        case "seekTo":
                            playerController.seekToMusic(call.argument("seek"));
                            break;
                        case "onInstanceIsPlaying":
                            result.success(playerController.onInstanceIsPlaying());
                            break;
                        default:
                            result.notImplemented();
                }
            }
        );

    }

}
