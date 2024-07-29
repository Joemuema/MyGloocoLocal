import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const NavBarPage() : const SignupWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? const NavBarPage() : const SignupWidget(),
        ),
        FFRoute(
          name: 'Signup',
          path: '/signup',
          builder: (context, params) => const SignupWidget(),
        ),
        FFRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'Home',
          path: '/home',
          builder: (context, params) =>
              params.isEmpty ? const NavBarPage(initialPage: 'Home') : const HomeWidget(),
        ),
        FFRoute(
          name: 'MedicationHome',
          path: '/medicationHome',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'MedicationHome')
              : const MedicationHomeWidget(),
        ),
        FFRoute(
          name: 'MedicationForm',
          path: '/medicationForm',
          builder: (context, params) => MedicationFormWidget(
            newMedicineID: params.getParam(
              'newMedicineID',
              ParamType.DocumentReference,
              isList: false,
              collectionNamePath: ['Medicine'],
            ),
            editMode: params.getParam(
              'editMode',
              ParamType.bool,
            ),
            addReminder: params.getParam(
              'addReminder',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: 'MedicationList',
          path: '/medicationList',
          builder: (context, params) => MedicationListWidget(
            addReminder: params.getParam(
              'addReminder',
              ParamType.bool,
            ),
            listOption: params.getParam(
              'listOption',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'userdetails',
          path: '/userdetails',
          builder: (context, params) => const UserdetailsWidget(),
        ),
        FFRoute(
          name: 'Settings',
          path: '/settings',
          builder: (context, params) => const SettingsWidget(),
        ),
        FFRoute(
          name: 'DietHome',
          path: '/dietHome',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'DietHome')
              : const DietHomeWidget(),
        ),
        FFRoute(
          name: 'YourMeals',
          path: '/yourMeals',
          builder: (context, params) => const YourMealsWidget(),
        ),
        FFRoute(
          name: 'Foodsearch',
          path: '/foodsearch',
          asyncParams: {
            'currentFoodList': getDocList(['food'], FoodRecord.fromSnapshot),
          },
          builder: (context, params) => FoodsearchWidget(
            currentFoodList: params.getParam<FoodRecord>(
              'currentFoodList',
              ParamType.Document,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: 'Foodview',
          path: '/foodview',
          builder: (context, params) => const FoodviewWidget(),
        ),
        FFRoute(
          name: 'Plate',
          path: '/plate',
          asyncParams: {
            'updatedFoodList': getDocList(['food'], FoodRecord.fromSnapshot),
          },
          builder: (context, params) => PlateWidget(
            updatedFoodList: params.getParam<FoodRecord>(
              'updatedFoodList',
              ParamType.Document,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: 'Recipe_list',
          path: '/recipeList',
          builder: (context, params) => const RecipeListWidget(),
        ),
        FFRoute(
          name: 'Recipe',
          path: '/recipe',
          asyncParams: {
            'recipeName': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
            'enkcal': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
            'carbs': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
            'proteins': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
            'fats': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
            'ingredients': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
            'instructions': getDoc(['Recipes'], RecipesRecord.fromSnapshot),
          },
          builder: (context, params) => RecipeWidget(
            recipeName: params.getParam(
              'recipeName',
              ParamType.Document,
            ),
            enkcal: params.getParam(
              'enkcal',
              ParamType.Document,
            ),
            carbs: params.getParam(
              'carbs',
              ParamType.Document,
            ),
            proteins: params.getParam(
              'proteins',
              ParamType.Document,
            ),
            fats: params.getParam(
              'fats',
              ParamType.Document,
            ),
            ingredients: params.getParam(
              'ingredients',
              ParamType.Document,
            ),
            instructions: params.getParam(
              'instructions',
              ParamType.Document,
            ),
            foodPic: params.getParam(
              'foodPic',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'edhome',
          path: '/edhome',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'edhome')
              : const EdhomeWidget(),
        ),
        FFRoute(
          name: 'intro2diabetes',
          path: '/intro2diabetes',
          builder: (context, params) => const Intro2diabetesWidget(),
        ),
        FFRoute(
          name: 'daily_management',
          path: '/dailyManagement',
          builder: (context, params) => const DailyManagementWidget(),
        ),
        FFRoute(
          name: 'monitoring_and_medication',
          path: '/monitoringAndMedication',
          builder: (context, params) => const MonitoringAndMedicationWidget(),
        ),
        FFRoute(
          name: 'healthy_eating',
          path: '/healthyEating',
          builder: (context, params) => const HealthyEatingWidget(),
        ),
        FFRoute(
          name: 'exercise_ed',
          path: '/exerciseEd',
          builder: (context, params) => const ExerciseEdWidget(),
        ),
        FFRoute(
          name: 'complications',
          path: '/complications',
          builder: (context, params) => const ComplicationsWidget(),
        ),
        FFRoute(
          name: 'mental_health',
          path: '/mentalHealth',
          builder: (context, params) => const MentalHealthWidget(),
        ),
        FFRoute(
          name: 'exercisehomepage',
          path: '/exercisehomepage',
          builder: (context, params) => params.isEmpty
              ? const NavBarPage(initialPage: 'exercisehomepage')
              : const ExercisehomepageWidget(),
        ),
        FFRoute(
          name: 'categoriespage',
          path: '/categoriespage',
          builder: (context, params) => const CategoriespageWidget(),
        ),
        FFRoute(
          name: 'addplanpage',
          path: '/addplanpage',
          builder: (context, params) => AddplanpageWidget(
            addtype: params.getParam(
              'addtype',
              ParamType.bool,
            ),
          ),
        ),
        FFRoute(
          name: 'lowerbodyexercise',
          path: '/lowerbodyexercise',
          builder: (context, params) => const LowerbodyexerciseWidget(),
        ),
        FFRoute(
          name: 'upperbodyexercises',
          path: '/upperbodyexercises',
          builder: (context, params) => const UpperbodyexercisesWidget(),
        ),
        FFRoute(
          name: 'Listpage',
          path: '/listpage',
          builder: (context, params) => const ListpageWidget(),
        ),
        FFRoute(
          name: 'Searchitemspage',
          path: '/searchitemspage',
          builder: (context, params) => const SearchitemspageWidget(),
        ),
        FFRoute(
          name: 'corebodyexercises',
          path: '/corebodyexercises',
          builder: (context, params) => const CorebodyexercisesWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/signup';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
