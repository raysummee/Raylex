package com.raysummee.raylex.raylex;

import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;

import androidx.annotation.NonNull;

import com.google.android.exoplayer2.DefaultRenderersFactory;
import com.google.android.exoplayer2.ExoPlayerFactory;
import com.google.android.exoplayer2.Player;
import com.google.android.exoplayer2.SimpleExoPlayer;
import com.google.android.exoplayer2.extractor.DefaultExtractorsFactory;
import com.google.android.exoplayer2.source.ExtractorMediaSource;
import com.google.android.exoplayer2.trackselection.DefaultTrackSelector;
import com.google.android.exoplayer2.trackselection.TrackSelector;
import com.google.android.exoplayer2.upstream.DefaultDataSourceFactory;
import com.google.android.exoplayer2.util.Util;
import com.raysummee.raylex.raylex.player.PlayerStateListener;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.Raysummee.raylex/audio";

    private MethodChannel channel;
    private final android.os.Handler handler = new Handler();
    private SimpleExoPlayer exoPlayer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        channel = new MethodChannel(getFlutterView(), CHANNEL);
                channel.setMethodCallHandler(
                (call, result) -> {
                    switch (call.method){
                        case "playMusic":
                            playMusic(call.argument("url"));
                            break;
                        case "pauseMusic":
                            pauseMusic();
                            break;
                        case "seekTo":
                            seekToMusic(call.argument("seek"));
                            break;
                        case "init":
                            handler.post(sendData);
                            break;
                        case "onInstanceIsPlaying":
                            result.success(onInstanceIsPlaying());
                            break;
                        default:
                            result.notImplemented();
                    }
                });
    }

    private void initExoPlayer(String uri) {
        DefaultRenderersFactory renderersFactory = new DefaultRenderersFactory(
                this,
                null,
                DefaultRenderersFactory.EXTENSION_RENDERER_MODE_OFF
        );
        TrackSelector trackSelector = new DefaultTrackSelector();
        exoPlayer = ExoPlayerFactory.newSimpleInstance(
                renderersFactory,
                trackSelector
        );
        String userAgent = Util.getUserAgent(this, "Raylex");
        ExtractorMediaSource mediaSource = new ExtractorMediaSource(
                Uri.parse(uri), // file audio ada di folder assets
                new DefaultDataSourceFactory(this, userAgent),
                new DefaultExtractorsFactory(),
                null,
                null
        );
        exoPlayer.prepare(mediaSource);
        exoPlayer.setPlayWhenReady(true);
        PlayerStateListener playerEventListener = new PlayerStateListener(channel, exoPlayer);
        exoPlayer.addListener(playerEventListener);
        //handler.post(sendData);
    }

    private void playMusic(String uri){
        if (exoPlayer!=null){
            if (!exoPlayer.getPlayWhenReady() || exoPlayer.getBufferedPosition()!=0){
                exoPlayer.setPlayWhenReady(true);
            }else {
                initExoPlayer(uri);
            }
        }else{
            initExoPlayer(uri);
        }
        handler.post(sendData);
        switch (exoPlayer.getPlaybackState()){
            case Player.STATE_IDLE:
                channel.invokeMethod("audio,onPause",null);
                break;
            case Player.STATE_READY:
                if(exoPlayer.getPlayWhenReady())
                    channel.invokeMethod("audio.onStart", exoPlayer.getDuration());
                else
                    channel.invokeMethod("audio.onPause", null);
                break;
            case Player.STATE_ENDED:
                channel.invokeMethod("audio.onStop", null);
                break;
            case Player.STATE_BUFFERING:
                channel.invokeMethod("audio.onBuffer", null);
                break;
        }

    }

    private void pauseMusic(){
        if (exoPlayer!=null){
            exoPlayer.setPlayWhenReady(false);
        }
    }

    private void seekToMusic(Double position){
        if (exoPlayer!=null){
            exoPlayer.seekTo(position.longValue());
        }
    }


    private boolean onInstanceIsPlaying(){
        return exoPlayer != null && exoPlayer.getPlaybackState() == Player.STATE_READY && exoPlayer.getPlayWhenReady();
    }


    private final Runnable sendData = new Runnable(){
        public void run(){
            try {
                if (!(exoPlayer.getPlaybackState() == Player.STATE_READY && exoPlayer.getPlayWhenReady())) {
                    handler.removeCallbacks(sendData);
                }
                long time = exoPlayer.getCurrentPosition();
                channel.invokeMethod("audio.onCurrentPosition", time);
                handler.postDelayed(this, 200);
            }
            catch (Exception e) {
                Log.w("ID", "When running handler", e);
            }
        }
    };
}
