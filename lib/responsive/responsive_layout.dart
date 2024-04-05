import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobilePage;
  final Widget desktopPage;

  const ResponsiveLayout({super.key, required this.mobilePage, required this.desktopPage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 600) {
        return mobilePage;
      }
      else {
        return desktopPage;
      }
    });
  }
}
