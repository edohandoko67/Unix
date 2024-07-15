import 'package:flutter/material.dart';

import 'dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget dekstopBody;

  ResponsiveLayout({required this.mobileBody, required this.dekstopBody});
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < mobileWidth){
            return mobileBody;
          } else {
            return dekstopBody;
          }
       },
    );
  }
}
