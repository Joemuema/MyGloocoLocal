import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/walkthrough_components/walkthrough_template/walkthrough_template_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

// Focus widget keys for this walkthrough
final iconButtonGzliz8gr = GlobalKey();
final columnVn3qc0p9 = GlobalKey();
final buttonWq2dzgnj = GlobalKey();
final icon6gs0ni15 = GlobalKey();
final iconT8nhjquh = GlobalKey();
final rowEm77b6f6 = GlobalKey();
final button87y4ko9k = GlobalKey();
final columnT8kwqqqg = GlobalKey();
final columnVg2795vw = GlobalKey();
final column6i2abtnq = GlobalKey();
final columnVj5rx2ra = GlobalKey();

/// HomePage Walkthrough
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// profileIcon
      TargetFocus(
        keyTarget: iconButtonGzliz8gr,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'View your user profile and other app settings',
            ),
          ),
        ],
      ),

      /// wholeChart
      TargetFocus(
        keyTarget: columnVn3qc0p9,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'This is your blood glucose chart for viewing all the readings you have recorded',
            ),
          ),
        ],
      ),

      /// selectChartDate
      TargetFocus(
        keyTarget: buttonWq2dzgnj,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Select the date to display glucose values for on the chart',
            ),
          ),
        ],
      ),

      /// nextDate
      TargetFocus(
        keyTarget: icon6gs0ni15,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press to move the date forwards',
            ),
          ),
        ],
      ),

      /// prevDate
      TargetFocus(
        keyTarget: iconT8nhjquh,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press to move the date backwards',
            ),
          ),
        ],
      ),

      /// avgReadings
      TargetFocus(
        keyTarget: rowEm77b6f6,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'This shows your glucose average depending on the time period you selected',
            ),
          ),
        ],
      ),

      /// chartSettings
      TargetFocus(
        keyTarget: button87y4ko9k,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Set chart settings like line type, time period and glucose units',
            ),
          ),
        ],
      ),

      /// logs
      TargetFocus(
        keyTarget: columnT8kwqqqg,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'These are your quick-access logs',
            ),
          ),
        ],
      ),

      /// bgLog
      TargetFocus(
        keyTarget: columnVg2795vw,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Log your blood glucose values here',
            ),
          ),
        ],
      ),

      /// foodLog
      TargetFocus(
        keyTarget: column6i2abtnq,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Log your meal details here',
            ),
          ),
        ],
      ),

      /// activityLog
      TargetFocus(
        keyTarget: columnVj5rx2ra,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Log your exercises and activity routines here',
            ),
          ),
        ],
      ),
    ];
