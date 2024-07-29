import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'mediumsintensitylistcomponent_model.dart';
export 'mediumsintensitylistcomponent_model.dart';

class MediumsintensitylistcomponentWidget extends StatefulWidget {
  const MediumsintensitylistcomponentWidget({
    super.key,
    required this.mediumintensitylistdocument,
    required this.checkboxaction,
  });

  final AddpagecollectionRecord? mediumintensitylistdocument;
  final Future Function()? checkboxaction;

  @override
  State<MediumsintensitylistcomponentWidget> createState() =>
      _MediumsintensitylistcomponentWidgetState();
}

class _MediumsintensitylistcomponentWidgetState
    extends State<MediumsintensitylistcomponentWidget> {
  late MediumsintensitylistcomponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediumsintensitylistcomponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 20.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 20.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                icon: FaIcon(
                  FontAwesomeIcons.react,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 40.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Activity:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: const Color(0xFF4D7E3E),
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  'Distance:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: const Color(0xFF4D7E3E),
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  'Date:',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        color: const Color(0xFF4D7E3E),
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.mediumintensitylistdocument?.activity,
                    'name',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  valueOrDefault<String>(
                    widget.mediumintensitylistdocument?.distance.toString(),
                    '0',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  valueOrDefault<String>(
                    dateTimeFormat(
                        'd/M/y', widget.mediumintensitylistdocument?.date),
                    '0',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
              ],
            ),
            Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                unselectedWidgetColor:
                    FlutterFlowTheme.of(context).secondaryText,
              ),
              child: Checkbox(
                value: _model.checkboxValue ??= true,
                onChanged: (newValue) async {
                  setState(() => _model.checkboxValue = newValue!);
                  if (newValue!) {
                    await widget.checkboxaction?.call();
                  }
                },
                side: BorderSide(
                  width: 2,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                activeColor: const Color(0xFF4D7E3E),
                checkColor: FlutterFlowTheme.of(context).info,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
