import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:player_app/action.dart';
import 'package:player_app/trackitem.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'appstate.dart';

/*Future<AppState> getSearchResult(Store<AppState> store) async{
  String url1 =
      "https://itunes.apple.com/search?term=" + store.state.searchText;
  var response = await http.get('https://itunes.apple.com/search?term=' + store.state.searchText');
}*/

ThunkAction<AppState> getSearchResult = (Store<AppState> store) async {
  String url1 =
      "https://itunes.apple.com/search?term=" + store.state.searchText;
  //final url = Uri.encodeFull(url1 + store.state.searchText);
  //var response = await http.get(url);

  // var response = await http.get(Uri.encodeFull(url1));
  Uri myUri = Uri.parse(url1);
  var response = await http.get(myUri);
  /* var response = await http.get(Uri.encodeFull(
      'https://itunes.apple.com/search?term=' + store.state.searchText));*/

  store.dispatch(UpdateTrackItemsAction(
      _decodeTrackItems(_decodeResultItems(response.body))));
};

ThunkAction<AppState> getAlbumTracks = (Store<AppState> store) async {
  var response = await http.get(
    Uri.parse(Uri.encodeFull(
        'https://itunes.apple.com/lookup?id=${store.state.albumId}&entity=song')),
  );

  final resultItems = _decodeResultItems(response.body);
  final releaseDate = _decodeAlbumReleaseDate(resultItems);
  final trackItems = _decodeTrackItems(resultItems);

  store.dispatch(AlbumTrackItemsAction(releaseDate, trackItems));
};

DateTime _decodeAlbumReleaseDate(List<dynamic> resultItems) {
  for (final value in resultItems) {
    if (value['wrapperType'] == 'collection' &&
        value['collectionType'] == 'Album') {
      return (value['releaseDate'] != null
          ? DateTime.parse(value['releaseDate'])
          : DateTime.now());
    }
  }

  return DateTime.now();
}

List<TrackItem> _decodeTrackItems(List<dynamic> resultItems) {
  var trackItems = List<TrackItem>();

  resultItems.forEach((value) {
    if (value['wrapperType'] == 'track' && value['kind'] == 'song') {
      final collectionName = value['collectionName'] ?? '';
      final collectionId = value['collectionId'];
      final artistName = value['artistName'] ?? '';
      final trackName = value['trackName'] ?? '';
      final artworkUrl = value['artworkUrl100'] ?? '';
      final audioPreviewUrl = value['previewUrl'] ?? '';
      final trackViewUrl = value['trackViewUrl'] ?? '';
      final trackDurationSeconds = (value['trackTimeMillis'] / 1000).round();

      final currencySymbol =
          NumberFormat().simpleCurrencySymbol(value['currency'] ?? '');
      final price = value['trackPrice'];

      final priceString = '$currencySymbol $price';

      final releaseDate = value['releaseDate'] != null
          ? DateTime.parse(value['releaseDate'])
          : DateTime.now();

      trackItems.add(TrackItem(
          collectionName,
          collectionId,
          artistName,
          trackName,
          artworkUrl,
          audioPreviewUrl,
          trackViewUrl,
          trackDurationSeconds,
          priceString,
          releaseDate));
    }
  });

  return trackItems;
}

List<dynamic> _decodeResultItems(String jsonData) {
  Map<String, dynamic> decodedData = jsonDecode(jsonData);
  return decodedData['results'];
}
