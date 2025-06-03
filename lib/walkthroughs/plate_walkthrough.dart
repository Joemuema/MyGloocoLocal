import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/walkthrough_components/walkthrough_template/walkthrough_template_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';

// Focus widget keys for this walkthrough
final imageF9xm7s8u = GlobalKey();
final containerTqtipktg = GlobalKey();
final containerGf742m1d = GlobalKey();
final containerZdkq6qzk = GlobalKey();
final iconButtonZnrvvwsr = GlobalKey();
final columnLnthx9qy = GlobalKey();

/// Plate Walkthrough
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// foodPlate
      TargetFocus(
        keyTarget: imageF9xm7s8u,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'This is a plate sectioned into different food categories. Use it to build your meal plate',
            ),
          ),
        ],
      ),

      /// fvSection
      TargetFocus(
        keyTarget: containerTqtipktg,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Press this section to add fruits/vegetables to your plate',
            ),
          ),
        ],
      ),

      /// carbSection
      TargetFocus(
        keyTarget: containerGf742m1d,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Press this section to add carbs/starch to your plate',
            ),
          ),
        ],
      ),

      /// protSection
      TargetFocus(
        keyTarget: containerZdkq6qzk,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Press this section to add proteins/meats to your plate',
            ),
          ),
        ],
      ),

      /// generalSearch
      TargetFocus(
        keyTarget: iconButtonZnrvvwsr,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, __) => WalkthroughTemplateWidget(
              description:
                  'Press the + button to add uncategorized foods to your plate, eg. Tea/Coffee',
            ),
          ),
        ],
      ),

      /// guide
      TargetFocus(
        keyTarget: columnLnthx9qy,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.RRect,
        color: FlutterFlowTheme.of(context).secondaryText,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => WalkthroughTemplateWidget(
              description: 'Check this table for recommended meal portioning',
            ),
          ),
        ],
      ),
    ];
