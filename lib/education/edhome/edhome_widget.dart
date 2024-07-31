import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'edhome_model.dart';
export 'edhome_model.dart';

class EdhomeWidget extends StatefulWidget {
  const EdhomeWidget({super.key});

  @override
  State<EdhomeWidget> createState() => _EdhomeWidgetState();
}

class _EdhomeWidgetState extends State<EdhomeWidget> {
  late EdhomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EdhomeModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            'Education',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.pushNamed('intro2diabetes');
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 380.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: Image.network(
                                'https://images.unsplash.com/photo-1603398938378-e54eab446dde?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxNXx8bWVkaWNpbmV8ZW58MHx8fHwxNzIwNDIzMzM1fDA&ixlib=rb-4.0.3&q=80&w=1080',
                              ).image,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Container(
                          width: 380.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            color: const Color(0x3C0C0101),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.bookOpen,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5.0, 5.0, 5.0, 5.0),
                                        child: Text(
                                          'Introduction to Diabetes Management',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1504674900247-0877df9cc836?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxmb29kfGVufDB8fHx8MTcyMDM2MDI4NHww&ixlib=rb-4.0.3&q=80&w=1080',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: const Color(0x3C0C0101),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('healthy_eating');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.fastfood_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            5.0, 5.0, 5.0, 5.0),
                                        child: Text(
                                          'Diabetes and Healthy Eating',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1513593771513-7b58b6c4af38?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyMXx8cnVubmluZ3xlbnwwfHx8fDE3MjE4MjAyNTl8MA&ixlib=rb-4.0.3&q=80&w=1080',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: const Color(0x3C0C0101),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('exercise_ed');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.running,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 5.0),
                                        child: Text(
                                          'Exercise and Physical Activity',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1593491205049-7f032d28cf5c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxkaWFiZXRlc3xlbnwwfHx8fDE3MjA0MjM1MTV8MA&ixlib=rb-4.0.3&q=80&w=1080',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: const Color(0x3C0C0101),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('monitoring_and_medication');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.pills,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 20.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 5.0),
                                        child: Text(
                                          'Monitoring and Medication',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxob3NwaXRhbHxlbnwwfHx8fDE3MjA0Mzc5NDN8MA&ixlib=rb-4.0.3&q=80&w=1080',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: const BoxDecoration(
                          color: Color(0x3C0C0101),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('complications');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.sick,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 5.0),
                                        child: Text(
                                          'Managing Complications',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1493836512294-502baa1986e2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHxtZW50YWwlMjBoZWFsdGh8ZW58MHx8fHwxNzIwNDI0MTM5fDA&ixlib=rb-4.0.3&q=80&w=1080',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        width: 480.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: const Color(0x3C0C0101),
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              '',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('mental_health');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.brain,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 22.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 5.0),
                                        child: Text(
                                          'Mental and Emotional Health',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: Image.network(
                              'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxzY2hlZHVsZXxlbnwwfHx8fDE3MjA0MjQyNzJ8MA&ixlib=rb-4.0.3&q=80&w=1080',
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      Container(
                        width: 380.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: const Color(0x3C0C0101),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('daily_management');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0xCC00A8AF),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.calendar_month,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xCC00A8AF),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 5.0),
                                        child: Text(
                                          'Tips for Daily Management',
                                          textAlign: TextAlign.center,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color: const Color(0xFEFFFFFF),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]
                                      .divide(const SizedBox(width: 10.0))
                                      .around(const SizedBox(width: 10.0)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ].divide(const SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
