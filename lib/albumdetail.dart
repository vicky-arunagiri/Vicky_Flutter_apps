import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:player_app/action.dart';
import 'package:player_app/main.dart';
import 'package:player_app/trackitem.dart';

class AlbumDetail extends StatelessWidget {
  TrackItem _trackItem;
  String _backgroundImageUrl;
  AlbumDetail(TrackItem trackItem) {
    _trackItem = trackItem;
    _backgroundImageUrl = dirname(_trackItem.imageUrl) +
        '/1000x1000-999' +
        extension(_trackItem.imageUrl);

    store.dispatch(AlbumDetailsAction(_trackItem.albumId));
    //store.dispatch(getAlbumTracks);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
