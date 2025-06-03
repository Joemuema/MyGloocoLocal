import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'chart_settings_page_model.dart';
export 'chart_settings_page_model.dart';

class ChartSettingsPageWidget extends StatefulWidget {
  const ChartSettingsPageWidget({
    super.key,
    this.chartType,
    this.unitsUsed,
    this.chartInterval,
    this.chartDate,
  });

  final String? chartType;
  final String? unitsUsed;
  final String? chartInterval;
  final DateTime? chartDate;

  static String routeName = 'chartSettingsPage';
  static String routePath = '/chartSettingsPage';

  @override
  State<ChartSettingsPageWidget> createState() =>
      _ChartSettingsPageWidgetState();
}

class _ChartSettingsPageWidgetState extends State<ChartSettingsPageWidget> {
  late ChartSettingsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChartSettingsPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      context.pushNamed(
        HomeWidget.routeName,
        queryParameters: {
          'setChartType': serializeParam(
            widget.chartType,
            ParamType.String,
          ),
          'setChartUnits': serializeParam(
            widget.unitsUsed,
            ParamType.String,
          ),
          'setInterval': serializeParam(
            widget.chartInterval,
            ParamType.String,
          ),
          'chartDate': serializeParam(
            widget.chartDate,
            ParamType.DateTime,
          ),
        }.withoutNulls,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
    );
  }
}
