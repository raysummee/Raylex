package com.raysummee.raylex.raylex.player;

import com.google.android.exoplayer2.ExoPlayer;
import com.google.android.exoplayer2.Player;
import com.google.android.exoplayer2.SimpleExoPlayer;

import io.flutter.plugin.common.MethodChannel;

public class PlayerStateListener implements Player.EventListener {


    private MethodChannel channel;
    private SimpleExoPlayer exoPlayer;
    public PlayerStateListener(MethodChannel channel, SimpleExoPlayer exoPlayer){
        this.channel = channel;
        this.exoPlayer = exoPlayer;
    }


    @Override
    public void onPlayerStateChanged(boolean playWhenReady, int playbackState) {
        switch (playbackState){
            case Player.STATE_IDLE:
                channel.invokeMethod("audio,onPause",null);
                break;
            case Player.STATE_READY:
                if(playWhenReady)
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
}
