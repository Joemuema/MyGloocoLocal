import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/walkthrough_components/walkthrough_template/walkthrough_template_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

// Focus widget keys for this walkthrough
final column1j4erg0o = GlobalKey();
final icon1sa5wstp = GlobalKey();
final container0n1khyj2 = GlobalKey();
final columnE05d3c6g = GlobalKey();
final columnCg52rv2p = GlobalKey();
final columnBbgc6yjs = GlobalKey();
final buttonE5029ssv = GlobalKey();
final floatingActionButtonE55yxbi1 = GlobalKey();

/// Med Walkthrough
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// mainCalendar
      TargetFocus(
        keyTarget: column1j4erg0o,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'This is the main calendar that you can use to keep track your medicine reminder schedules ',
            ),
          ),
        ],
      ),

      /// expandIcon
      TargetFocus(
        keyTarget: icon1sa5wstp,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press this icon to expand/contract the calendar',
            ),
          ),
        ],
      ),

      /// fullCalendar
      TargetFocus(
        keyTarget: container0n1khyj2,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press here to access the full calendar interface',
            ),
          ),
        ],
      ),

      /// upcomingRems
      TargetFocus(
        keyTarget: columnE05d3c6g,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'All your upcoming reminders are shown here',
            ),
          ),
        ],
      ),

      /// taken
      TargetFocus(
        keyTarget: columnCg52rv2p,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'All the taken medicine reminders are shown here',
            ),
          ),
        ],
      ),

      /// missed
      TargetFocus(
        keyTarget: columnBbgc6yjs,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'All the missed medicine reminders are shown here',
            ),
          ),
        ],
      ),

      /// addReminder
      TargetFocus(
        keyTarget: buttonE5029ssv,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Press this button to schedule a new reminder for your medicine ',
            ),
          ),
        ],
      ),

      /// medMenu
      TargetFocus(
        keyTarget: floatingActionButtonE55yxbi1,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Press this button to open the medication menu',
            ),
          ),
        ],
      ),
    ];
