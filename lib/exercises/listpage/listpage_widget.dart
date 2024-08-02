import '/backend/backend.dart';
import '/exercises/highintensitylistcomponents/highintensitylistcomponents_widget.dart';
import '/exercises/lowintensitylistcomponent/lowintensitylistcomponent_widget.dart';
import '/exercises/mediumsintensitylistcomponent/mediumsintensitylistcomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/medication/no_elements/no_elements_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'listpage_model.dart';
export 'listpage_model.dart';

class ListpageWidget extends StatefulWidget {
  const ListpageWidget({super.key});

  @override
  State<ListpageWidget> createState() => _ListpageWidgetState();
}

class _ListpageWidgetState extends State<ListpageWidget> {
  late ListpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListpageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<AddpagecollectionRecord>>(
      stream: queryAddpagecollectionRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<AddpagecollectionRecord> listpageAddpagecollectionRecordList =
            snapshot.data!;

        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'History',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Search',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('Searchitemspage');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Search for an Activity',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowIconButton(
                                  borderColor: Colors.transparent,
                                  borderRadius: 20.0,
                                  borderWidth: 1.0,
                                  buttonSize: 40.0,
                                  icon: const Icon(
                                    Icons.search,
                                    color: Color(0xFF4D7E3E),
                                    size: 24.0,
                                  ),
                                  onPressed: () {
                                    print('IconButton pressed ...');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Low Intensity',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: StreamBuilder<List<AddpagecollectionRecord>>(
                      stream: queryAddpagecollectionRecord(
                        queryBuilder: (addpagecollectionRecord) =>
                            addpagecollectionRecord
                                .where(
                                  'intensity',
                                  isEqualTo: 'Low',
                                )
                                .where(
                                  'completed',
                                  isEqualTo: true,
                                )
                                .where(
                                  'UserID',
                                  isEqualTo: FFAppState().UserID,
                                ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<AddpagecollectionRecord>
                            listViewAddpagecollectionRecordList =
                            snapshot.data!;
                        if (listViewAddpagecollectionRecordList.isEmpty) {
                          return const NoElementsWidget(
                            additionalText: ' ',
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewAddpagecollectionRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewAddpagecollectionRecord =
                                listViewAddpagecollectionRecordList[
                                    listViewIndex];
                            return wrapWithModel(
                              model: _model.lowintensitylistcomponentModels
                                  .getModel(
                                listViewAddpagecollectionRecord.reference.id,
                                listViewIndex,
                              ),
                              updateCallback: () => setState(() {}),
                              child: LowintensitylistcomponentWidget(
                                key: Key(
                                  'Key1t2_${listViewAddpagecollectionRecord.reference.id}',
                                ),
                                lowintensitylistcomponent:
                                    listViewAddpagecollectionRecord,
                                checkboxaction: () async {},
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Medium Intensity',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<List<AddpagecollectionRecord>>(
                    stream: queryAddpagecollectionRecord(
                      queryBuilder: (addpagecollectionRecord) =>
                          addpagecollectionRecord
                              .where(
                                'intensity',
                                isEqualTo: 'Medium',
                              )
                              .where(
                                'completed',
                                isEqualTo: true,
                              )
                              .where(
                                'UserID',
                                isEqualTo: FFAppState().UserID,
                              ),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<AddpagecollectionRecord>
                          listViewAddpagecollectionRecordList = snapshot.data!;
                      if (listViewAddpagecollectionRecordList.isEmpty) {
                        return const NoElementsWidget(
                          additionalText: '   ',
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewAddpagecollectionRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewAddpagecollectionRecord =
                              listViewAddpagecollectionRecordList[
                                  listViewIndex];
                          return wrapWithModel(
                            model: _model.mediumsintensitylistcomponentModels
                                .getModel(
                              listViewAddpagecollectionRecord.reference.id,
                              listViewIndex,
                            ),
                            updateCallback: () => setState(() {}),
                            child: MediumsintensitylistcomponentWidget(
                              key: Key(
                                'Keypux_${listViewAddpagecollectionRecord.reference.id}',
                              ),
                              mediumintensitylistdocument:
                                  listViewAddpagecollectionRecord,
                              checkboxaction: () async {},
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'High Intensity',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Inter',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 18.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<List<AddpagecollectionRecord>>(
                    stream: queryAddpagecollectionRecord(
                      queryBuilder: (addpagecollectionRecord) =>
                          addpagecollectionRecord
                              .where(
                                'intensity',
                                isEqualTo: 'High',
                              )
                              .where(
                                'completed',
                                isEqualTo: true,
                              )
                              .where(
                                'UserID',
                                isEqualTo: FFAppState().UserID,
                              ),
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        );
                      }
                      List<AddpagecollectionRecord>
                          listViewAddpagecollectionRecordList = snapshot.data!;
                      if (listViewAddpagecollectionRecordList.isEmpty) {
                        return const NoElementsWidget(
                          additionalText: '  ',
                        );
                      }

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewAddpagecollectionRecordList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewAddpagecollectionRecord =
                              listViewAddpagecollectionRecordList[
                                  listViewIndex];
                          return wrapWithModel(
                            model: _model.highintensitylistcomponentsModels
                                .getModel(
                              listViewAddpagecollectionRecord.reference.id,
                              listViewIndex,
                            ),
                            updateCallback: () => setState(() {}),
                            child: HighintensitylistcomponentsWidget(
                              key: Key(
                                'Key6mc_${listViewAddpagecollectionRecord.reference.id}',
                              ),
                              highintensitylistdocument:
                                  listViewAddpagecollectionRecord,
                              checkboxaction: () async {},
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
