import 'package:flutter/material.dart';

class ConditionalContent extends StatelessWidget {
  final bool condition;

  final Widget falsy;
  final Widget truthy;

  ConditionalContent({
    @required this.condition,
    @required this.truthy,
    @required this.falsy,
  })  : assert(condition != null),
        assert(truthy != null),
        assert(falsy != null);

  @override
  Widget build(BuildContext context) => condition ? truthy : falsy;
}
