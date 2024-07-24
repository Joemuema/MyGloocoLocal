import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _UserID = prefs.getString('ff_UserID')?.ref ?? _UserID;
    });
    _safeInit(() {
      _notificationPermissionsGranted =
          prefs.getBool('ff_notificationPermissionsGranted') ??
              _notificationPermissionsGranted;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  DocumentReference? _UserID;
  DocumentReference? get UserID => _UserID;
  set UserID(DocumentReference? value) {
    _UserID = value;
    value != null
        ? prefs.setString('ff_UserID', value.path)
        : prefs.remove('ff_UserID');
  }

  bool _notificationPermissionsGranted = false;
  bool get notificationPermissionsGranted => _notificationPermissionsGranted;
  set notificationPermissionsGranted(bool value) {
    _notificationPermissionsGranted = value;
    prefs.setBool('ff_notificationPermissionsGranted', value);
  }

  bool _searchActive = false;
  bool get searchActive => _searchActive;
  set searchActive(bool value) {
    _searchActive = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
