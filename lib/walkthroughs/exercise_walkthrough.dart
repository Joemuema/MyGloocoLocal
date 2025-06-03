import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/walkthrough_components/walkthrough_template/walkthrough_template_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

// Focus widget keys for this walkthrough
final column8vzwjrm2 = GlobalKey();
final button5q803pqs = GlobalKey();
final columnUt5tirfh = GlobalKey();
final button7bk6ml7b = GlobalKey();
final columnJ58ptzl2 = GlobalKey();
final buttonI4vm6ll7 = GlobalKey();

/// Exercise Walkthrough
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// categories
      TargetFocus(
        keyTarget: column8vzwjrm2,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'You can choose from these 3 different exercise categories',
            ),
          ),
        ],
      ),

      /// history
      TargetFocus(
        keyTarget: button5q803pqs,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Click to view your past activities and completed exercise routines',
            ),
          ),
        ],
      ),

      /// activityPlan
      TargetFocus(
        keyTarget: columnUt5tirfh,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'You can view your planned activities/exercises here',
            ),
          ),
        ],
      ),

      /// addPlan
      TargetFocus(
        keyTarget: button7bk6ml7b,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press to plan an activity/exercise',
            ),
          ),
        ],
      ),

      /// todayActivity
      TargetFocus(
        keyTarget: columnJ58ptzl2,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'You can view today\'s activities here',
            ),
          ),
        ],
      ),

      /// addToday
      TargetFocus(
        keyTarget: buttonI4vm6ll7,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press to schedule an activity for today',
            ),
          ),
        ],
      ),
    ];
