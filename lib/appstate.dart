import 'package:meta/meta.dart';
import 'package:player_app/trackitem.dart';

@immutable
class AppState {
  final String searchText;
  final List<TrackItem> trackItems;
  final String activePlayingAudioUrl;
  final Duration currentAudioDuration;
  final int albumId;
  final List<TrackItem> albumItems;
  final DateTime albumReleaseDate;

  AppState(
      {@required this.searchText,
      @required this.trackItems,
      @required this.activePlayingAudioUrl,
      @required this.currentAudioDuration,
      @required this.albumId,
      @required this.albumItems,
      @required this.albumReleaseDate});

  factory AppState.initial() {
    return AppState(
        searchText: '',
        trackItems: List<TrackItem>(),
        activePlayingAudioUrl: '',
        currentAudioDuration: Duration(),
        albumId: 0,
        albumItems: List<TrackItem>(),
        albumReleaseDate: DateTime.now());
  }

  copyWith(
      {String searchText,
      List<TrackItem> trackItems,
      String activePlayingAudioUrl,
      Duration currentAudioDuration,
      int albumId,
      List<TrackItem> albumItems,
      DateTime albumReleaseDate}) {
    return AppState(
        searchText: searchText ?? this.searchText,
        trackItems: trackItems != null
            ? (List<TrackItem>()..addAll(trackItems))
            : (List<TrackItem>()..addAll(this.trackItems)),
        activePlayingAudioUrl:
            activePlayingAudioUrl ?? this.activePlayingAudioUrl,
        currentAudioDuration: currentAudioDuration ?? this.currentAudioDuration,
        albumId: albumId ?? this.albumId,
        albumItems: albumItems != null
            ? (List<TrackItem>()..addAll(albumItems))
            : (List<TrackItem>()..addAll(this.albumItems)),
        albumReleaseDate: albumReleaseDate ?? this.albumReleaseDate);
  }
}
