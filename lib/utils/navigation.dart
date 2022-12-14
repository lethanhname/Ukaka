import 'package:flutter/material.dart';

navigateReplace(BuildContext context, Widget route, {isDialog = false}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        fullscreenDialog: isDialog,
        builder: (context) => route,
      ),
    );

navigate(BuildContext context, Widget route, {isDialog = false}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: isDialog,
        builder: (context) => route,
      ),
    );

popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);


popView(BuildContext context) => Navigator.pop(context);

navigateTransparentRoute(BuildContext context, Widget route) {
  return Navigator.push(
    context,
    TransparentRoute(
      builder: (context) => route,
    ),
  );
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    required this.builder,
    RouteSettings? settings,
  })  : super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;
}