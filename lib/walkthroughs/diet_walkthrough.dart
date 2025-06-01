import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/walkthrough_components/walkthrough_template/walkthrough_template_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

// Focus widget keys for this walkthrough
final rowNlzphme0 = GlobalKey();
final containerY4aox3q3 = GlobalKey();
final column5xkjqpk5 = GlobalKey();
final columnQr5zumjh = GlobalKey();
final buttonRodxwv3l = GlobalKey();
final button4wv9u2sv = GlobalKey();

/// Diet Walkthrough
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// tabSwitch
      TargetFocus(
        keyTarget: rowNlzphme0,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'You can switch between the main diet page and the recipes page',
            ),
          ),
        ],
      ),

      /// generalSearch
      TargetFocus(
        keyTarget: containerY4aox3q3,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Search for food items and view their calorie information',
            ),
          ),
        ],
      ),

      /// mealPlan
      TargetFocus(
        keyTarget: column5xkjqpk5,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Access the meal calendar to view your past meals or plan for future meals',
            ),
          ),
        ],
      ),

      /// mealLogs
      TargetFocus(
        keyTarget: columnQr5zumjh,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Log your meals here according to the meal period',
            ),
          ),
        ],
      ),

      /// plate
      TargetFocus(
        keyTarget: buttonRodxwv3l,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Open the plate interface to put together your meal',
            ),
          ),
        ],
      ),

      /// drinks
      TargetFocus(
        keyTarget: button4wv9u2sv,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Record your drinks here',
            ),
          ),
        ],
      ),
    ];
