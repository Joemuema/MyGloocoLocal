import 'package:flutter/widgets.dart';

class FFIcons {
  FFIcons._();

  static const String _tabletIconFamily = 'TabletIcon';
  static const String _pillIconFamily = 'PillIcon';
  static const String _emulsionIconFamily = 'EmulsionIcon';
  static const String _injectionIconFamily = 'InjectionIcon';

  // TabletIcon
  static const IconData kmedicine =
      IconData(0xe805, fontFamily: _tabletIconFamily);

  // PillIcon
  static const IconData kdrug = IconData(0xe806, fontFamily: _pillIconFamily);

  // EmulsionIcon
  static const IconData ksyrup =
      IconData(0xe807, fontFamily: _emulsionIconFamily);

  // InjectionIcon
  static const IconData kinjection =
      IconData(0xe808, fontFamily: _injectionIconFamily);
}
