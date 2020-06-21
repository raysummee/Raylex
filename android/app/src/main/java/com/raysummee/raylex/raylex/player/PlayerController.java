package com.raysummee.raylex.raylex.player;

import android.content.Context;
import android.net.Uri;
import android.os.Handler;

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

import java.lang.reflect.Method;

import io.flutter.Log;
import io.flutter.plugin.common.MethodChannel;

public class PlayerController{
    Context context;
    MethodChannel channel;
    String lastUri;
    public PlayerController(Context context, MethodChannel channel){
        this.context = context;
        this.channel = channel;
    }

    private final android.os.Handler handler = new Handler();
    private SimpleExoPlayer exoPlayer;

    public void initExoPlayer(String uri) {
        lastUri = uri;
        if(exoPlayer!=null){
            exoPlayer.release();
        }
        DefaultRenderersFactory renderersFactory = new DefaultRenderersFactory(
                context,
                null,
                DefaultRenderersFactory.EXTENSION_RENDERER_MODE_OFF
        );
        TrackSelector trackSelector = new DefaultTrackSelector();
        exoPlayer = ExoPlayerFactory.newSimpleInstance(
                renderersFactory,
                trackSelector
        );
        String userAgent = Util.getUserAgent(context, "Raylex");
        ExtractorMediaSource mediaSource = new ExtractorMediaSource(
                Uri.parse(uri), // file audio ada di folder assets
                new DefaultDataSourceFactory(context, userAgent),
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

    public void playMusic(String uri){
        if (exoPlayer!=null && lastUri.equals(uri)){
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

    public void pauseMusic(){
        if (exoPlayer!=null){
            exoPlayer.setPlayWhenReady(false);
        }
    }

    public void seekToMusic(Double position){
        if (exoPlayer!=null){
            exoPlayer.seekTo(position.longValue());
        }
    }

    public long getAudioDuration(){
        if(exoPlayer!=null){
            return exoPlayer.getDuration();
        }else{
            return 0;
        }
    }


    public boolean onInstanceIsPlaying(){
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
