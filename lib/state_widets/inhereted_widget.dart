import 'package:flutter/widgets.dart';

class StateInheretedWidget extends InheritedWidget {
  final child;
  bool natija;
  StateInheretedWidget({Key, key, required this.child, required this.natija})
      : super(key: key, child: child);

  static bool of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<StateInheretedWidget>()!
      .natija;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget != child;
  }
}
