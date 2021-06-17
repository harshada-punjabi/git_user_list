import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:provider/provider.dart';

import 'di/providers.dart';
import 'git_user_landing_page_application.dart';
import 'git_user_landing_page_application_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZoned(() {
    runApp(
      MultiProvider(
        providers: providers,
        child: MainAppWidget(),
      ),
    );
  });
}

class MainAppWidget extends StatelessWidget {
  @override
  Widget build(context) {
    return BaseWidget<GitUserLandingPageApplicationViewModel>(
        viewModel: GitUserLandingPageApplicationViewModel(),
        onModelReady: (m) {},
        builder: (context, model, _) {
          return GitUserLandingPageApplication();
        });
  }
}
