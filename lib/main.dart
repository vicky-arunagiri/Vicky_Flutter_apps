import 'package:flutter/material.dart';
import 'package:player_app/appstate.dart';
import 'package:player_app/flutteritunesapp.dart';
import 'package:player_app/reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

Store<AppState> store;
void main() {
  store = Store<AppState>(reducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);

  runApp(FlutteriTunesApp(store));
}
