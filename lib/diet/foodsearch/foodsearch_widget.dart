import '/backend/backend.dart';
import '/diet/access_from_main_tab/access_from_main_tab_widget.dart';
import '/diet/diet_access/diet_access_widget.dart';
import '/diet/foodsearch/foodsearchcomponent/foodsearchcomponent_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'foodsearch_model.dart';
export 'foodsearch_model.dart';

class FoodsearchWidget extends StatefulWidget {
  const FoodsearchWidget({
    super.key,
    this.currentFoodList,
    this.location,
    this.filter,
    this.foodPeriod,
    this.currentKcalList,
    this.currentMassList,
    int? chosenMealTime,
    bool? mealPlanning,
    this.planDate,
  })  : this.chosenMealTime = chosenMealTime ?? 0,
        this.mealPlanning = mealPlanning ?? false;

  final List<FilteredFoodRecord>? currentFoodList;
  final String? location;
  final String? filter;
  final String? foodPeriod;
  final List<double>? currentKcalList;
  final List<double>? currentMassList;
  final int chosenMealTime;
  final bool mealPlanning;
  final DateTime? planDate;

  static String routeName = 'Foodsearch';
  static String routePath = '/foodsearch';

  @override
  State<FoodsearchWidget> createState() => _FoodsearchWidgetState();
}

class _FoodsearchWidgetState extends State<FoodsearchWidget>
    with TickerProviderStateMixin {
  late FoodsearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FoodsearchModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().searchActive = false;
      safeSetState(() {});
      _model.searchFoodList =
          widget.currentFoodList!.toList().cast<FilteredFoodRecord>();
      _model.filter = widget.filter;
      _model.searchKcalList = widget.currentKcalList!.toList().cast<double>();
      _model.searchMassList = widget.currentMassList!.toList().cast<double>();
      safeSetState(() {});
    });

    _model.searchbarTextController ??= TextEditingController();
    _model.searchbarFocusNode ??= FocusNode();

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Food Search',
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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(1.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 0.0),
                          child: TextFormField(
                            controller: _model.searchbarTextController,
                            focusNode: _model.searchbarFocusNode,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.searchbarTextController',
                              Duration(milliseconds: 2000),
                              () async {
                                await queryFilteredFoodRecordOnce()
                                    .then(
                                      (records) => _model.simpleSearchResults =
                                          TextSearch(
                                        records
                                            .map(
                                              (record) =>
                                                  TextSearchItem.fromTerms(
                                                      record, [record.food]),
                                            )
                                            .toList(),
                                      )
                                              .search(_model
                                                  .searchbarTextController.text)
                                              .map((r) => r.object)
                                              .take(20)
                                              .toList(),
                                    )
                                    .onError((_, __) =>
                                        _model.simpleSearchResults = [])
                                    .whenComplete(() => safeSetState(() {}));

                                FFAppState().searchActive = true;
                                safeSetState(() {});
                              },
                            ),
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: false,
                              labelText: 'Search...',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
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
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            maxLines: null,
                            validator: _model.searchbarTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        icon: Icon(
                          Icons.clear_sharp,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          safeSetState(() {
                            _model.searchbarTextController?.clear();
                          });
                          FFAppState().searchActive = false;
                          safeSetState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 0.0, 0.0),
                      child: Text(
                        'Food items matching search:',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            14.0, 12.0, 16.0, 0.0),
                        child: Text(
                          widget.location == 'Sheet'
                              ? (FFAppState().searchActive
                                  ? _model.simpleSearchResults.length.toString()
                                  : '0')
                              : (FFAppState().searchActive
                                  ? _model.simpleSearchResults
                                      .where((e) => e.category == _model.filter)
                                      .toList()
                                      .length
                                      .toString()
                                  : '0'),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
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
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    if ((widget.location == 'Sheet') ||
                        (widget.location == 'toPlate')) {
                      return Builder(
                        builder: (context) {
                          if (FFAppState().searchActive) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final results =
                                      _model.simpleSearchResults.toList();

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: results.length,
                                    itemBuilder: (context, resultsIndex) {
                                      final resultsItem = results[resultsIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 1.0),
                                        child: Container(
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (widget.location ==
                                                          'Plate') {
                                                        _model
                                                            .addToSearchFoodList(
                                                                resultsItem);
                                                        _model
                                                            .addToSearchKcalList(
                                                                resultsItem
                                                                    .energyKcal);
                                                        _model
                                                            .addToSearchMassList(
                                                                100.0);
                                                        safeSetState(() {});

                                                        context.pushNamed(
                                                          PlateWidget.routeName,
                                                          queryParameters: {
                                                            'updatedFoodList':
                                                                serializeParam(
                                                              _model
                                                                  .searchFoodList,
                                                              ParamType
                                                                  .Document,
                                                              isList: true,
                                                            ),
                                                            'updatedKcalList':
                                                                serializeParam(
                                                              _model
                                                                  .searchKcalList,
                                                              ParamType.double,
                                                              isList: true,
                                                            ),
                                                            'updatedMassList':
                                                                serializeParam(
                                                              _model
                                                                  .searchMassList,
                                                              ParamType.double,
                                                              isList: true,
                                                            ),
                                                            'mealPlanning':
                                                                serializeParam(
                                                              widget
                                                                  .mealPlanning,
                                                              ParamType.bool,
                                                            ),
                                                            'planDate':
                                                                serializeParam(
                                                              widget.planDate,
                                                              ParamType
                                                                  .DateTime,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'updatedFoodList':
                                                                _model
                                                                    .searchFoodList,
                                                          },
                                                        );
                                                      } else {
                                                        if (widget.location ==
                                                            'toPlate') {
                                                          _model
                                                              .addToSearchFoodList(
                                                                  resultsItem);
                                                          _model.addToSearchKcalList(
                                                              resultsItem
                                                                  .energyKcal);
                                                          _model
                                                              .addToSearchMassList(
                                                                  100.0);
                                                          safeSetState(() {});
                                                          context.safePop();
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      DietAccessWidget(
                                                                    updatedFoodList:
                                                                        _model
                                                                            .searchFoodList,
                                                                    foodPeriod:
                                                                        widget
                                                                            .foodPeriod,
                                                                    updatedKcalList:
                                                                        _model
                                                                            .searchKcalList,
                                                                    updatedMassList:
                                                                        _model
                                                                            .searchMassList,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        } else {
                                                          _model
                                                              .addToSearchFoodList(
                                                                  resultsItem);
                                                          _model.addToSearchKcalList(
                                                              resultsItem
                                                                  .energyKcal);
                                                          _model
                                                              .addToSearchMassList(
                                                                  100.0);
                                                          safeSetState(() {});
                                                          context.safePop();
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      AccessFromMainTabWidget(
                                                                    updatedFoodList:
                                                                        _model
                                                                            .searchFoodList,
                                                                    updatedKcalList:
                                                                        _model
                                                                            .searchKcalList,
                                                                    updatedMassList:
                                                                        _model
                                                                            .searchMassList,
                                                                    prevMealTime:
                                                                        widget
                                                                            .chosenMealTime,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            resultsItem.food,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  resultsItem
                                                                      .carbohydrates
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'g carbs',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            14.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  resultsItem
                                                                      .energyKcal
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'kCal',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: StreamBuilder<List<FilteredFoodRecord>>(
                                stream: queryFilteredFoodRecord(
                                  limit: 50,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<FilteredFoodRecord>
                                      listViewFilteredFoodRecordList =
                                      snapshot.data!;

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewFilteredFoodRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewFilteredFoodRecord =
                                          listViewFilteredFoodRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (widget.location == 'Plate') {
                                            _model.addToSearchFoodList(
                                                listViewFilteredFoodRecord);
                                            _model.addToSearchKcalList(
                                                listViewFilteredFoodRecord
                                                    .energyKcal);
                                            _model.addToSearchMassList(100.0);
                                            safeSetState(() {});

                                            context.pushNamed(
                                              PlateWidget.routeName,
                                              queryParameters: {
                                                'updatedFoodList':
                                                    serializeParam(
                                                  _model.searchFoodList,
                                                  ParamType.Document,
                                                  isList: true,
                                                ),
                                                'updatedKcalList':
                                                    serializeParam(
                                                  _model.searchKcalList,
                                                  ParamType.double,
                                                  isList: true,
                                                ),
                                                'updatedMassList':
                                                    serializeParam(
                                                  _model.searchMassList,
                                                  ParamType.double,
                                                  isList: true,
                                                ),
                                                'mealPlanning': serializeParam(
                                                  widget.mealPlanning,
                                                  ParamType.bool,
                                                ),
                                                'planDate': serializeParam(
                                                  widget.planDate,
                                                  ParamType.DateTime,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'updatedFoodList':
                                                    _model.searchFoodList,
                                              },
                                            );
                                          } else {
                                            if (widget.location == 'toPlate') {
                                              _model.addToSearchFoodList(
                                                  listViewFilteredFoodRecord);
                                              _model.addToSearchKcalList(
                                                  listViewFilteredFoodRecord
                                                      .energyKcal);
                                              _model.addToSearchMassList(100.0);
                                              safeSetState(() {});
                                              context.safePop();
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: DietAccessWidget(
                                                        updatedFoodList: _model
                                                            .searchFoodList,
                                                        foodPeriod:
                                                            widget.foodPeriod,
                                                        updatedKcalList: _model
                                                            .searchKcalList,
                                                        updatedMassList: _model
                                                            .searchMassList,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            } else {
                                              _model.addToSearchFoodList(
                                                  listViewFilteredFoodRecord);
                                              _model.addToSearchKcalList(
                                                  listViewFilteredFoodRecord
                                                      .energyKcal);
                                              _model.addToSearchMassList(100.0);
                                              safeSetState(() {});
                                              context.safePop();
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child:
                                                          AccessFromMainTabWidget(
                                                        updatedFoodList: _model
                                                            .searchFoodList,
                                                        updatedKcalList: _model
                                                            .searchKcalList,
                                                        updatedMassList: _model
                                                            .searchMassList,
                                                        prevMealTime: widget
                                                            .chosenMealTime,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            }
                                          }
                                        },
                                        child: FoodsearchcomponentWidget(
                                          key: Key(
                                              'Key99o_${listViewIndex}_of_${listViewFilteredFoodRecordList.length}'),
                                          parameter1:
                                              listViewFilteredFoodRecord.food,
                                          parameter2: listViewFilteredFoodRecord
                                              .carbohydrates,
                                          parameter3: listViewFilteredFoodRecord
                                              .energyKcal,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return Builder(
                        builder: (context) {
                          if (FFAppState().searchActive) {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final results = _model.simpleSearchResults
                                      .where((e) => e.category == _model.filter)
                                      .toList();

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: results.length,
                                    itemBuilder: (context, resultsIndex) {
                                      final resultsItem = results[resultsIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 1.0),
                                        child: Container(
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0.0,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      if (widget.location ==
                                                          'Plate') {
                                                        _model
                                                            .addToSearchFoodList(
                                                                resultsItem);
                                                        _model
                                                            .addToSearchKcalList(
                                                                resultsItem
                                                                    .energyKcal);
                                                        _model
                                                            .addToSearchMassList(
                                                                100.0);
                                                        safeSetState(() {});

                                                        context.pushNamed(
                                                          PlateWidget.routeName,
                                                          queryParameters: {
                                                            'updatedFoodList':
                                                                serializeParam(
                                                              _model
                                                                  .searchFoodList,
                                                              ParamType
                                                                  .Document,
                                                              isList: true,
                                                            ),
                                                            'updatedKcalList':
                                                                serializeParam(
                                                              _model
                                                                  .searchKcalList,
                                                              ParamType.double,
                                                              isList: true,
                                                            ),
                                                            'updatedMassList':
                                                                serializeParam(
                                                              _model
                                                                  .searchMassList,
                                                              ParamType.double,
                                                              isList: true,
                                                            ),
                                                            'mealPlanning':
                                                                serializeParam(
                                                              widget
                                                                  .mealPlanning,
                                                              ParamType.bool,
                                                            ),
                                                            'planDate':
                                                                serializeParam(
                                                              widget.planDate,
                                                              ParamType
                                                                  .DateTime,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'updatedFoodList':
                                                                _model
                                                                    .searchFoodList,
                                                          },
                                                        );
                                                      } else {
                                                        if (widget.location ==
                                                            'toPlate') {
                                                          _model
                                                              .addToSearchFoodList(
                                                                  resultsItem);
                                                          _model.addToSearchKcalList(
                                                              resultsItem
                                                                  .energyKcal);
                                                          _model
                                                              .addToSearchMassList(
                                                                  100.0);
                                                          safeSetState(() {});
                                                          context.safePop();
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      DietAccessWidget(
                                                                    updatedFoodList:
                                                                        _model
                                                                            .searchFoodList,
                                                                    foodPeriod:
                                                                        widget
                                                                            .foodPeriod,
                                                                    updatedKcalList:
                                                                        _model
                                                                            .searchKcalList,
                                                                    updatedMassList:
                                                                        _model
                                                                            .searchMassList,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        } else {
                                                          _model
                                                              .addToSearchFoodList(
                                                                  resultsItem);
                                                          _model.addToSearchKcalList(
                                                              resultsItem
                                                                  .energyKcal);
                                                          _model
                                                              .addToSearchMassList(
                                                                  100.0);
                                                          safeSetState(() {});
                                                          context.safePop();
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .unfocus();
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      AccessFromMainTabWidget(
                                                                    updatedFoodList:
                                                                        _model
                                                                            .searchFoodList,
                                                                    updatedKcalList:
                                                                        _model
                                                                            .searchKcalList,
                                                                    updatedMassList:
                                                                        _model
                                                                            .searchMassList,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        }
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      12.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            resultsItem.food,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyLarge
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      4.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  resultsItem
                                                                      .carbohydrates
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'g carbs',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            14.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Text(
                                                                  resultsItem
                                                                      .energyKcal
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .readexPro(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'kCal',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: StreamBuilder<List<FilteredFoodRecord>>(
                                stream: queryFilteredFoodRecord(
                                  queryBuilder: (filteredFoodRecord) =>
                                      filteredFoodRecord.where(
                                    'Category',
                                    isEqualTo: _model.filter,
                                  ),
                                  limit: 50,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<FilteredFoodRecord>
                                      listViewFilteredFoodRecordList =
                                      snapshot.data!;

                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewFilteredFoodRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewFilteredFoodRecord =
                                          listViewFilteredFoodRecordList[
                                              listViewIndex];
                                      return InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          if (widget.location == 'Plate') {
                                            _model.addToSearchFoodList(
                                                listViewFilteredFoodRecord);
                                            _model.addToSearchKcalList(
                                                listViewFilteredFoodRecord
                                                    .energyKcal);
                                            _model.addToSearchMassList(100.0);
                                            safeSetState(() {});

                                            context.pushNamed(
                                              PlateWidget.routeName,
                                              queryParameters: {
                                                'updatedFoodList':
                                                    serializeParam(
                                                  _model.searchFoodList,
                                                  ParamType.Document,
                                                  isList: true,
                                                ),
                                                'updatedKcalList':
                                                    serializeParam(
                                                  _model.searchKcalList,
                                                  ParamType.double,
                                                  isList: true,
                                                ),
                                                'updatedMassList':
                                                    serializeParam(
                                                  _model.searchMassList,
                                                  ParamType.double,
                                                  isList: true,
                                                ),
                                                'mealPlanning': serializeParam(
                                                  widget.mealPlanning,
                                                  ParamType.bool,
                                                ),
                                                'planDate': serializeParam(
                                                  widget.planDate,
                                                  ParamType.DateTime,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'updatedFoodList':
                                                    _model.searchFoodList,
                                              },
                                            );
                                          } else {
                                            if (widget.location == 'toPlate') {
                                              _model.addToSearchFoodList(
                                                  listViewFilteredFoodRecord);
                                              _model.addToSearchKcalList(
                                                  listViewFilteredFoodRecord
                                                      .energyKcal);
                                              _model.addToSearchMassList(100.0);
                                              safeSetState(() {});
                                              context.safePop();
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child: DietAccessWidget(
                                                        updatedFoodList: _model
                                                            .searchFoodList,
                                                        foodPeriod:
                                                            widget.foodPeriod,
                                                        updatedKcalList: _model
                                                            .searchKcalList,
                                                        updatedMassList: _model
                                                            .searchMassList,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            } else {
                                              _model.addToSearchFoodList(
                                                  listViewFilteredFoodRecord);
                                              _model.addToSearchKcalList(
                                                  listViewFilteredFoodRecord
                                                      .energyKcal);
                                              _model.addToSearchMassList(100.0);
                                              safeSetState(() {});
                                              context.safePop();
                                              await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: Padding(
                                                      padding: MediaQuery
                                                          .viewInsetsOf(
                                                              context),
                                                      child:
                                                          AccessFromMainTabWidget(
                                                        updatedFoodList: _model
                                                            .searchFoodList,
                                                        updatedKcalList: _model
                                                            .searchKcalList,
                                                        updatedMassList: _model
                                                            .searchMassList,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ).then((value) =>
                                                  safeSetState(() {}));
                                            }
                                          }
                                        },
                                        child: FoodsearchcomponentWidget(
                                          key: Key(
                                              'Keymfe_${listViewIndex}_of_${listViewFilteredFoodRecordList.length}'),
                                          parameter1:
                                              listViewFilteredFoodRecord.food,
                                          parameter2: listViewFilteredFoodRecord
                                              .carbohydrates,
                                          parameter3: listViewFilteredFoodRecord
                                              .energyKcal,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
