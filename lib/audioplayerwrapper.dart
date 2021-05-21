import 'package:audioplayers/audioplayers.dart';
import 'package:player_app/action.dart';
import 'package:player_app/audiodownloader.dart';
import 'package:player_app/main.dart';

class AudioPlayerWrapper {
  static final AudioPlayerWrapper _singleton =
      new AudioPlayerWrapper._internal();

  final _audioPlayer = AudioPlayer();
  final _audioDownloader = AudioDownloader();

  factory AudioPlayerWrapper() {
    return _singleton;
  }

  AudioPlayerWrapper._internal() {
    _audioPlayer.onAudioPositionChanged.listen(_onAudioDurationChange);
    _audioPlayer.onPlayerStateChanged.listen(_onAudioPlayerStateChange);
  }

  playTrack(String url) async {
    var previewFilename = await _audioDownloader.downloadUrl(url);
    await _audioPlayer.play(previewFilename, isLocal: true);

    store.dispatch(PlayAudioUrlAction(url));
  }

  stopTrack() async {
    await _audioPlayer.stop();
    store.dispatch(StopAudioAction());
  }

  _onAudioDurationChange(Duration duration) {
    store.dispatch(AudioDurationChangedAction(duration));
  }

  _onAudioPlayerStateChange(PlayerState state) {
    //_onAudioPlayerStateChange(AudioPlayerState state) {
    if (state == PlayerState.COMPLETED) {
      store.dispatch(CompletedAudioAction());
    }
  }
}
