import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
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
    _safeInit(() {
      _lastUpdatedReminders = prefs.containsKey('ff_lastUpdatedReminders')
          ? DateTime.fromMillisecondsSinceEpoch(
              prefs.getInt('ff_lastUpdatedReminders')!)
          : _lastUpdatedReminders;
    });
    _safeInit(() {
      _homeTutorial = prefs.getBool('ff_homeTutorial') ?? _homeTutorial;
    });
    _safeInit(() {
      _medTutorial = prefs.getBool('ff_medTutorial') ?? _medTutorial;
    });
    _safeInit(() {
      _dietHomeTutorial =
          prefs.getBool('ff_dietHomeTutorial') ?? _dietHomeTutorial;
    });
    _safeInit(() {
      _plateTutorial = prefs.getBool('ff_plateTutorial') ?? _plateTutorial;
    });
    _safeInit(() {
      _exerciseTutorial =
          prefs.getBool('ff_exerciseTutorial') ?? _exerciseTutorial;
    });
    _safeInit(() {
      _signedIn = prefs.getBool('ff_signedIn') ?? _signedIn;
    });
    _safeInit(() {
      _recsStored = prefs.getBool('ff_recsStored') ?? _recsStored;
    });
    _safeInit(() {
      _foodItemsStored =
          prefs.getBool('ff_foodItemsStored') ?? _foodItemsStored;
    });
    _safeInit(() {
      _recipesStored = prefs.getBool('ff_recipesStored') ?? _recipesStored;
    });
    _safeInit(() {
      _strExStored = prefs.getBool('ff_strExStored') ?? _strExStored;
    });
    _safeInit(() {
      _aerobicExStored =
          prefs.getBool('ff_aerobicExStored') ?? _aerobicExStored;
    });
    _safeInit(() {
      _flexExStored = prefs.getBool('ff_flexExStored') ?? _flexExStored;
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

  DateTime? _lastUpdatedReminders =
      DateTime.fromMillisecondsSinceEpoch(1704056400000);
  DateTime? get lastUpdatedReminders => _lastUpdatedReminders;
  set lastUpdatedReminders(DateTime? value) {
    _lastUpdatedReminders = value;
    value != null
        ? prefs.setInt('ff_lastUpdatedReminders', value.millisecondsSinceEpoch)
        : prefs.remove('ff_lastUpdatedReminders');
  }

  bool _medicineRemindersUpdated = false;
  bool get medicineRemindersUpdated => _medicineRemindersUpdated;
  set medicineRemindersUpdated(bool value) {
    _medicineRemindersUpdated = value;
  }

  bool _homeTutorial = false;
  bool get homeTutorial => _homeTutorial;
  set homeTutorial(bool value) {
    _homeTutorial = value;
    prefs.setBool('ff_homeTutorial', value);
  }

  bool _medTutorial = false;
  bool get medTutorial => _medTutorial;
  set medTutorial(bool value) {
    _medTutorial = value;
    prefs.setBool('ff_medTutorial', value);
  }

  bool _dietHomeTutorial = false;
  bool get dietHomeTutorial => _dietHomeTutorial;
  set dietHomeTutorial(bool value) {
    _dietHomeTutorial = value;
    prefs.setBool('ff_dietHomeTutorial', value);
  }

  bool _plateTutorial = false;
  bool get plateTutorial => _plateTutorial;
  set plateTutorial(bool value) {
    _plateTutorial = value;
    prefs.setBool('ff_plateTutorial', value);
  }

  bool _exerciseTutorial = false;
  bool get exerciseTutorial => _exerciseTutorial;
  set exerciseTutorial(bool value) {
    _exerciseTutorial = value;
    prefs.setBool('ff_exerciseTutorial', value);
  }

  bool _signedIn = false;
  bool get signedIn => _signedIn;
  set signedIn(bool value) {
    _signedIn = value;
    prefs.setBool('ff_signedIn', value);
  }

  bool _recsStored = false;
  bool get recsStored => _recsStored;
  set recsStored(bool value) {
    _recsStored = value;
    prefs.setBool('ff_recsStored', value);
  }

  bool _foodItemsStored = false;
  bool get foodItemsStored => _foodItemsStored;
  set foodItemsStored(bool value) {
    _foodItemsStored = value;
    prefs.setBool('ff_foodItemsStored', value);
  }

  bool _recipesStored = false;
  bool get recipesStored => _recipesStored;
  set recipesStored(bool value) {
    _recipesStored = value;
    prefs.setBool('ff_recipesStored', value);
  }

  bool _strExStored = false;
  bool get strExStored => _strExStored;
  set strExStored(bool value) {
    _strExStored = value;
    prefs.setBool('ff_strExStored', value);
  }

  bool _aerobicExStored = false;
  bool get aerobicExStored => _aerobicExStored;
  set aerobicExStored(bool value) {
    _aerobicExStored = value;
    prefs.setBool('ff_aerobicExStored', value);
  }

  bool _flexExStored = false;
  bool get flexExStored => _flexExStored;
  set flexExStored(bool value) {
    _flexExStored = value;
    prefs.setBool('ff_flexExStored', value);
  }

  final _foodsetManager = StreamRequestManager<List<FoodRecord>>();
  Stream<List<FoodRecord>> foodset({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<FoodRecord>> Function() requestFn,
  }) =>
      _foodsetManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFoodsetCache() => _foodsetManager.clear();
  void clearFoodsetCacheKey(String? uniqueKey) =>
      _foodsetManager.clearRequest(uniqueKey);
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
