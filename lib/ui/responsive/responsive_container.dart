import 'package:flutter/material.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final double padding;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.maxWidth = 1140,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.xs({
    Key? key,
    required this.child,
    this.maxWidth = 540,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.sm({
    Key? key,
    required this.child,
    this.maxWidth = 720,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.md({
    Key? key,
    required this.child,
    this.maxWidth = 960,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.lg({
    Key? key,
    required this.child,
    this.maxWidth = 1140,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.xl({
    Key? key,
    required this.child,
    this.maxWidth = 1320,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.xxl({
    Key? key,
    required this.child,
    this.maxWidth = 1500,
    this.padding = 0,
  }) : super(key: key);

  const ResponsiveContainer.fluid({
    Key? key,
    required this.child,
    this.maxWidth = double.infinity,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    );
  }
}
