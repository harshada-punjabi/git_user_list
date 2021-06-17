import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'git_user_landing_page_route_path.dart';
import 'git_user_landing_page_router.dart';

class GitUserLandingPageApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 4096,
          minWidth: 360,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(360, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      initialRoute: GitUserLandingRoutePaths.Landing,
      onGenerateRoute: GitUserLandingRouter.generateRoute,
    );
  }
}
