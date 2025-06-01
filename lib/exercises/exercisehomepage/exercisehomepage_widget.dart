import '/backend/backend.dart';
import '/exercises/exercisetaskstodaycomponent/exercisetaskstodaycomponent_widget.dart';
import '/exercises/incompleteactivitylist/incompleteactivitylist_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/logs/addactivity/addactivity_widget.dart';
import '/medication/no_elements/no_elements_widget.dart';
import '/walkthroughs/exercise_walkthrough.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'exercisehomepage_model.dart';
export 'exercisehomepage_model.dart';

class ExercisehomepageWidget extends StatefulWidget {
  const ExercisehomepageWidget({super.key});

  static String routeName = 'exercisehomepage';
  static String routePath = '/exercisehomepage';

  @override
  State<ExercisehomepageWidget> createState() => _ExercisehomepageWidgetState();
}

class _ExercisehomepageWidgetState extends State<ExercisehomepageWidget> {
  late ExercisehomepageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ExercisehomepageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().exerciseTutorial == false) {
        safeSetState(() => _model.exerciseWalkthroughController =
            createPageWalkthrough(context));
        _model.exerciseWalkthroughController?.show(context: context);
        FFAppState().exerciseTutorial = true;
        safeSetState(() {});
      }
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Exercise',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'Categories',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 19.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(CategoriespageWidget.routeName);
                          },
                          child: Text(
                            'See More',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      height: 180.0,
                      child: CarouselSlider(
                        items: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                CategoriespageWidget.routeName,
                                queryParameters: {
                                  'tabIndex': serializeParam(
                                    0,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1524594152303-9fd13543fe6e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxhZXJvYmljJTIwfGVufDB8fHx8MTcxOTMwNjUxMHww&ixlib=rb-4.0.3&q=80&w=1080',
                                      width: 207.0,
                                      height: 134.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Text(
                                      'Aerobic Exercises',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                CategoriespageWidget.routeName,
                                queryParameters: {
                                  'tabIndex': serializeParam(
                                    1,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1521804906057-1df8fdb718b7?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxzdHJlbmd0aCUyMHRyYWluaW5nfGVufDB8fHx8MTcxOTMwNjU1NXww&ixlib=rb-4.0.3&q=80&w=1080',
                                      width: 207.0,
                                      height: 134.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Text(
                                      'Strength Training',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                CategoriespageWidget.routeName,
                                queryParameters: {
                                  'tabIndex': serializeParam(
                                    2,
                                    ParamType.int,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://images.unsplash.com/photo-1561900478-5001f6b4d8ed?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxiYWxhbmNlfGVufDB8fHx8MTcxOTMwNjU5NHww&ixlib=rb-4.0.3&q=80&w=1080',
                                      width: 207.0,
                                      height: 134.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Text(
                                      'Flexibility and Balance',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        carouselController: _model.carouselController ??=
                            CarouselSliderController(),
                        options: CarouselOptions(
                          initialPage: 1,
                          viewportFraction: 0.5,
                          disableCenter: true,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.25,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayInterval:
                              Duration(milliseconds: (800 + 4000)),
                          autoPlayCurve: Curves.linear,
                          pauseAutoPlayInFiniteScroll: false,
                          onPageChanged: (index, _) =>
                              _model.carouselCurrentIndex = index,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                30.0, 0.0, 30.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(ListpageWidget.routeName);
                              },
                              text: 'View Activity History',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ).addWalkthrough(
                              button5q803pqs,
                              _model.exerciseWalkthroughController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).addWalkthrough(
                column8vzwjrm2,
                _model.exerciseWalkthroughController,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Plan Activity',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: AddactivityWidget(
                                        completed: false,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) => safeSetState(() {}));
                            },
                            text: 'Add',
                            icon: Icon(
                              Icons.add,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              height: 25.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ).addWalkthrough(
                            button7bk6ml7b,
                            _model.exerciseWalkthroughController,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: StreamBuilder<List<AddpagecollectionRecord>>(
                        stream: queryAddpagecollectionRecord(
                          queryBuilder: (addpagecollectionRecord) =>
                              addpagecollectionRecord
                                  .where(
                                    'completed',
                                    isEqualTo: false,
                                  )
                                  .where(
                                    'UserID',
                                    isEqualTo: FFAppState().UserID,
                                  )
                                  .orderBy('date'),
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
                            return NoElementsWidget(
                              additionalText: 'Enter a plan',
                            );
                          }

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                listViewAddpagecollectionRecordList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10.0),
                            itemBuilder: (context, listViewIndex) {
                              final listViewAddpagecollectionRecord =
                                  listViewAddpagecollectionRecordList[
                                      listViewIndex];
                              return wrapWithModel(
                                model: _model.incompleteactivitylistModels
                                    .getModel(
                                  listViewAddpagecollectionRecord.reference.id,
                                  listViewIndex,
                                ),
                                updateCallback: () => safeSetState(() {}),
                                child: IncompleteactivitylistWidget(
                                  key: Key(
                                    'Keyru6_${listViewAddpagecollectionRecord.reference.id}',
                                  ),
                                  incompleteactivitydocument:
                                      listViewAddpagecollectionRecord,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ).addWalkthrough(
                  columnUt5tirfh,
                  _model.exerciseWalkthroughController,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today\'s Activities',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .headlineSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: AddactivityWidget(
                                          completed: true,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              text: 'Add',
                              icon: Icon(
                                Icons.add,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 25.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ).addWalkthrough(
                              buttonI4vm6ll7,
                              _model.exerciseWalkthroughController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: StreamBuilder<List<AddpagecollectionRecord>>(
                          stream: queryAddpagecollectionRecord(
                            queryBuilder: (addpagecollectionRecord) =>
                                addpagecollectionRecord
                                    .where(
                                      'date',
                                      isEqualTo: functions
                                          .currentDate(getCurrentTimestamp),
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
                              return NoElementsWidget(
                                additionalText: 'Enter today\'s activities',
                              );
                            }

                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  listViewAddpagecollectionRecordList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 10.0),
                              itemBuilder: (context, listViewIndex) {
                                final listViewAddpagecollectionRecord =
                                    listViewAddpagecollectionRecordList[
                                        listViewIndex];
                                return wrapWithModel(
                                  model: _model
                                      .exercisetaskstodaycomponentModels
                                      .getModel(
                                    listViewAddpagecollectionRecord
                                        .reference.id,
                                    listViewIndex,
                                  ),
                                  updateCallback: () => safeSetState(() {}),
                                  child: ExercisetaskstodaycomponentWidget(
                                    key: Key(
                                      'Keywpc_${listViewAddpagecollectionRecord.reference.id}',
                                    ),
                                    taskstodaydocument:
                                        listViewAddpagecollectionRecord,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ).addWalkthrough(
                  columnJ58ptzl2,
                  _model.exerciseWalkthroughController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TutorialCoachMark createPageWalkthrough(BuildContext context) =>
      TutorialCoachMark(
        targets: createWalkthroughTargets(context),
        onFinish: () async {
          safeSetState(() => _model.exerciseWalkthroughController = null);
        },
        onSkip: () {
          return true;
        },
      );
}
