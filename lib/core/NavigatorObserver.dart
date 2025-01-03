import 'package:flutter/material.dart';

class CurrentNavigationObserver extends NavigatorObserver {
  static final List<Route> _routeStack = [];


  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute == null) {
      if (newRoute != null) {
        // Add the route to the top?
        _routeStack.add(newRoute);
      }
      return;
    }

    // Probably never happens, but anyway..
    if (newRoute == null) {
      _routeStack.remove(oldRoute);
      return;
    }

    if (_routeStack.contains(oldRoute)) {
      _routeStack[_routeStack.indexOf(oldRoute)] = newRoute;
    } else {
      // Add the route to the top?
      _routeStack.add(newRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);
  }

  static void displayStack() {
    print('Current Route Stack:');
    for (var route in _routeStack) {
      print('Route: ${route.settings.name}');
    }
  }

}
