import '/backend/backend.dart';
import '/diet/foodsearch/food_checkout/food_checkout_widget.dart';
import '/diet/meal_food_item/meal_food_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plate_model.dart';
export 'plate_model.dart';

class PlateWidget extends StatefulWidget {
  const PlateWidget({
    super.key,
    this.updatedFoodList,
    this.updatedKcalList,
    this.updatedMassList,
  });

  final List<FilteredFoodRecord>? updatedFoodList;
  final List<double>? updatedKcalList;
  final List<double>? updatedMassList;

  static String routeName = 'Plate';
  static String routePath = '/plate';

  @override
  State<PlateWidget> createState() => _PlateWidgetState();
}

class _PlateWidgetState extends State<PlateWidget> {
  late PlateModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlateModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.updatedFoodList =
          widget.updatedFoodList!.toList().cast<FilteredFoodRecord>();
      _model.kcalList = widget.updatedKcalList!.toList().cast<double>();
      _model.massList = widget.updatedMassList!.toList().cast<double>();
      _model.totalKcal = valueOrDefault<double>(
        functions.calcTotalKcal(_model.kcalList.toList()),
        0.0,
      );
      safeSetState(() {});
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
              context.safePop();
            },
          ),
          title: Text(
            'Plate',
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
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      height: 406.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.asset(
                                  'assets/images/output-onlinepngtools.png',
                                  width: MediaQuery.sizeOf(context).width,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.51, 0.18),
                            child: Text(
                              'Fruits &',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.53, 0.27),
                            child: Text(
                              'Vegetables',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.83, 0.05),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  FoodsearchWidget.routeName,
                                  queryParameters: {
                                    'currentFoodList': serializeParam(
                                      _model.updatedFoodList,
                                      ParamType.Document,
                                      isList: true,
                                    ),
                                    'location': serializeParam(
                                      'Plate',
                                      ParamType.String,
                                    ),
                                    'filter': serializeParam(
                                      'V',
                                      ParamType.String,
                                    ),
                                    'currentKcalList': serializeParam(
                                      _model.kcalList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                    'currentMassList': serializeParam(
                                      _model.massList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'currentFoodList': _model.updatedFoodList,
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.42,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.42,
                                      0.0,
                                    )),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft:
                                        Radius.circular(valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.42,
                                      0.0,
                                    )),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.43, -0.22),
                            child: Text(
                              'Carbs',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.77, -0.75),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  FoodsearchWidget.routeName,
                                  queryParameters: {
                                    'currentFoodList': serializeParam(
                                      _model.updatedFoodList,
                                      ParamType.Document,
                                      isList: true,
                                    ),
                                    'location': serializeParam(
                                      'Plate',
                                      ParamType.String,
                                    ),
                                    'filter': serializeParam(
                                      'C',
                                      ParamType.String,
                                    ),
                                    'currentKcalList': serializeParam(
                                      _model.kcalList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                    'currentMassList': serializeParam(
                                      _model.massList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'currentFoodList': _model.updatedFoodList,
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.42,
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight:
                                        Radius.circular(valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.42,
                                      0.0,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.45, 0.5),
                            child: Text(
                              'Proteins',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.76, 0.75),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  FoodsearchWidget.routeName,
                                  queryParameters: {
                                    'currentFoodList': serializeParam(
                                      _model.updatedFoodList,
                                      ParamType.Document,
                                      isList: true,
                                    ),
                                    'location': serializeParam(
                                      'Plate',
                                      ParamType.String,
                                    ),
                                    'filter': serializeParam(
                                      'P',
                                      ParamType.String,
                                    ),
                                    'currentKcalList': serializeParam(
                                      _model.kcalList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                    'currentMassList': serializeParam(
                                      _model.massList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'currentFoodList': _model.updatedFoodList,
                                  },
                                );
                              },
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.42,
                                height: MediaQuery.sizeOf(context).height * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0.0),
                                    bottomRight:
                                        Radius.circular(valueOrDefault<double>(
                                      MediaQuery.sizeOf(context).width * 0.42,
                                      0.0,
                                    )),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.44, 0.36),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 49.0,
                                fillColor: Colors.white,
                                icon: Icon(
                                  FFIcons.kicons8Meat50,
                                  color: Color(0xFF0D0D0D),
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed(
                                    FoodsearchWidget.routeName,
                                    queryParameters: {
                                      'currentFoodList': serializeParam(
                                        _model.updatedFoodList,
                                        ParamType.Document,
                                        isList: true,
                                      ),
                                      'location': serializeParam(
                                        'Plate',
                                        ParamType.String,
                                      ),
                                      'filter': serializeParam(
                                        'P',
                                        ParamType.String,
                                      ),
                                      'currentKcalList': serializeParam(
                                        _model.kcalList,
                                        ParamType.double,
                                        isList: true,
                                      ),
                                      'currentMassList': serializeParam(
                                        _model.massList,
                                        ParamType.double,
                                        isList: true,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'currentFoodList': _model.updatedFoodList,
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(-0.5, -0.01),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 49.0,
                                fillColor: Colors.white,
                                icon: FaIcon(
                                  FontAwesomeIcons.carrot,
                                  color: Color(0xFF0D0D0D),
                                  size: 29.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed(
                                    FoodsearchWidget.routeName,
                                    queryParameters: {
                                      'currentFoodList': serializeParam(
                                        _model.updatedFoodList,
                                        ParamType.Document,
                                        isList: true,
                                      ),
                                      'location': serializeParam(
                                        'Plate',
                                        ParamType.String,
                                      ),
                                      'filter': serializeParam(
                                        'V',
                                        ParamType.String,
                                      ),
                                      'currentKcalList': serializeParam(
                                        _model.kcalList,
                                        ParamType.double,
                                        isList: true,
                                      ),
                                      'currentMassList': serializeParam(
                                        _model.massList,
                                        ParamType.double,
                                        isList: true,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'currentFoodList': _model.updatedFoodList,
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.45, -0.45),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 49.0,
                                fillColor: Colors.white,
                                icon: Icon(
                                  FFIcons.kicons8Wheat50,
                                  color: Color(0xFF0D0D0D),
                                  size: 30.0,
                                ),
                                onPressed: () async {
                                  context.pushNamed(
                                    FoodsearchWidget.routeName,
                                    queryParameters: {
                                      'currentFoodList': serializeParam(
                                        _model.updatedFoodList,
                                        ParamType.Document,
                                        isList: true,
                                      ),
                                      'location': serializeParam(
                                        'Plate',
                                        ParamType.String,
                                      ),
                                      'filter': serializeParam(
                                        'C',
                                        ParamType.String,
                                      ),
                                      'currentKcalList': serializeParam(
                                        _model.kcalList,
                                        ParamType.double,
                                        isList: true,
                                      ),
                                      'currentMassList': serializeParam(
                                        _model.massList,
                                        ParamType.double,
                                        isList: true,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'currentFoodList': _model.updatedFoodList,
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.93, 0.99),
                            child: FlutterFlowIconButton(
                              borderColor: FlutterFlowTheme.of(context).primary,
                              borderRadius: 20.0,
                              borderWidth: 2.0,
                              buttonSize: 49.0,
                              fillColor: Colors.white,
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 30.0,
                              ),
                              onPressed: () async {
                                context.pushNamed(
                                  FoodsearchWidget.routeName,
                                  queryParameters: {
                                    'currentFoodList': serializeParam(
                                      _model.updatedFoodList,
                                      ParamType.Document,
                                      isList: true,
                                    ),
                                    'location': serializeParam(
                                      'toPlate',
                                      ParamType.String,
                                    ),
                                    'currentKcalList': serializeParam(
                                      _model.kcalList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                    'currentMassList': serializeParam(
                                      _model.massList,
                                      ParamType.double,
                                      isList: true,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    'currentFoodList': _model.updatedFoodList,
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 10.0, 0.0),
                                child: Text(
                                  'Default estimations are per 100g of edible portion on fresh weight basis. (You can change the estimate mass in each food item\'s mass textfield)\n\nTo search for uncategorized food items, click (+) button in the bottom-right corner of the plate.',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.readexPro(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
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
                      ],
                    ),
                    if (widget.updatedFoodList != null &&
                        (widget.updatedFoodList)!.isNotEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 4.0, 0.0, 0.0),
                              child: Text(
                                'Summary',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          if (widget.updatedKcalList != null &&
                              (widget.updatedKcalList)!.isNotEmpty)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 5.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Total Kcal:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 15.0, 0.0),
                                    child: Text(
                                      '${valueOrDefault<String>(
                                        formatNumber(
                                          _model.totalKcal,
                                          formatType: FormatType.custom,
                                          format: '.00',
                                          locale: 'en_US',
                                        ),
                                        '0',
                                      )} Kcal',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 17.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
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
                          Builder(
                            builder: (context) {
                              final foodList = _model.updatedFoodList.toList();

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: foodList.length,
                                itemBuilder: (context, foodListIndex) {
                                  final foodListItem = foodList[foodListIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 5.0, 10.0, 5.0),
                                    child: wrapWithModel(
                                      model: _model.mealFoodItemModels.getModel(
                                        foodListIndex.toString(),
                                        foodListIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: MealFoodItemWidget(
                                        key: Key(
                                          'Key3ub_${foodListIndex.toString()}',
                                        ),
                                        foodItem: foodListItem,
                                        massValue: valueOrDefault<double>(
                                          _model.massList
                                              .elementAtOrNull(foodListIndex),
                                          100.0,
                                        ),
                                        removeFoodItem: () async {
                                          _model.removeFromUpdatedFoodList(
                                              foodListItem);
                                          _model.removeAtIndexFromKcalList(
                                              foodListIndex);
                                          _model.removeAtIndexFromMassList(
                                              foodListIndex);
                                          safeSetState(() {});
                                        },
                                        changeKcalValue:
                                            (kcalValue, mass) async {
                                          _model.updateKcalListAtIndex(
                                            foodListIndex,
                                            (_) => kcalValue,
                                          );
                                          _model.updateMassListAtIndex(
                                            foodListIndex,
                                            (_) => mass,
                                          );
                                          _model.totalKcal =
                                              valueOrDefault<double>(
                                            functions.calcTotalKcal(
                                                _model.kcalList.toList()),
                                            0.0,
                                          );
                                          safeSetState(() {});
                                        },
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 10.0, 24.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
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
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: FoodCheckoutWidget(
                                                      finalfoodlist: _model
                                                          .updatedFoodList,
                                                      finalKcal:
                                                          _model.totalKcal,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                          text: 'Record Meal',
                                          options: FFButtonOptions(
                                            width: double.infinity,
                                            height: 50.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                            elevation: 3.0,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
