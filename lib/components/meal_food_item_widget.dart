import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'meal_food_item_model.dart';
export 'meal_food_item_model.dart';

class MealFoodItemWidget extends StatefulWidget {
  const MealFoodItemWidget({
    super.key,
    required this.foodItem,
    required this.removeFoodItem,
    this.changeKcalValue,
    double? massValue,
  }) : massValue = massValue ?? 100.0;

  final FilteredFoodRecord? foodItem;
  final Future Function()? removeFoodItem;
  final Future Function(double kcalValue, double mass)? changeKcalValue;
  final double massValue;

  @override
  State<MealFoodItemWidget> createState() => _MealFoodItemWidgetState();
}

class _MealFoodItemWidgetState extends State<MealFoodItemWidget> {
  late MealFoodItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MealFoodItemModel());

    _model.textController1 ??= TextEditingController(
        text: valueOrDefault<String>(
      widget.foodItem?.food,
      'foodname',
    ));
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??=
        TextEditingController(text: widget.massValue.toString());
    _model.textFieldFocusNode2 ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  0.0,
                  0.0,
                  valueOrDefault<double>(
                    MediaQuery.sizeOf(context).width * 0.02,
                    0.0,
                  ),
                  0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 8.0, 0.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: TextFormField(
                              controller: _model.textController1,
                              focusNode: _model.textFieldFocusNode1,
                              autofocus: false,
                              readOnly: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                hintStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 17.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                              maxLines: null,
                              validator: _model.textController1Validator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Form(
                              key: _model.formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Align(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 0.0, 0.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.15,
                                    child: TextFormField(
                                      controller: _model.textController2,
                                      focusNode: _model.textFieldFocusNode2,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController2',
                                        const Duration(milliseconds: 700),
                                        () async {
                                          if (_model.formKey.currentState ==
                                                  null ||
                                              !_model.formKey.currentState!
                                                  .validate()) {
                                            return;
                                          }
                                          _model.textfieldupdated = true;
                                          setState(() {});
                                          await widget.changeKcalValue?.call(
                                            valueOrDefault<double>(
                                              (widget.foodItem!.energyKcal /
                                                      100) *
                                                  double.parse(_model
                                                      .textController2.text),
                                              0.0,
                                            ),
                                            double.parse(
                                                _model.textController2.text),
                                          );
                                        },
                                      ),
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                          ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      validator: _model.textController2Validator
                                          .asValidator(context),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 0.0, 0.0),
                          child: Text(
                            'g',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 17.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15.0, 0.0, 0.0, 0.0),
                            child: Text(
                              formatNumber(
                                (widget.foodItem!.energyKcal *
                                        double.parse(
                                            _model.textController2.text)) /
                                    100,
                                formatType: FormatType.custom,
                                format: '###.##',
                                locale: '',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          Text(
                            ' kCal',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            formatNumber(
                              (widget.foodItem!.protein / 100) *
                                  double.parse(_model.textController2.text),
                              formatType: FormatType.custom,
                              format: '###.##',
                              locale: '',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                          Text(
                            ' g Protein',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 15.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                formatNumber(
                                  (widget.foodItem!.carbohydrates / 100) *
                                      double.parse(_model.textController2.text),
                                  formatType: FormatType.custom,
                                  format: '###.##',
                                  locale: '',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Text(
                              ' g Carbs',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              formatNumber(
                                (widget.foodItem!.fat / 100) *
                                    double.parse(_model.textController2.text),
                                formatType: FormatType.custom,
                                format: '###.##',
                                locale: '',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            Text(
                              ' g Fats',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0.0,
                      0.0,
                      valueOrDefault<double>(
                        MediaQuery.sizeOf(context).width * 0.01,
                        0.0,
                      ),
                      0.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onDoubleTap: () async {
                      await widget.removeFoodItem?.call();
                    },
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 20.0,
                      borderWidth: 1.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.clear_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        print('IconButton pressed ...');
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
