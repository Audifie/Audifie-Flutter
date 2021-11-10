import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/route_generator.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/authentication/presenter/notifiers/auth_notifier.dart';
import 'package:audifie_version_1/features/page_selector/presenter/notifiers/page_selector_notifier.dart';
import 'package:audifie_version_1/features/page_selector/presenter/pages/base_home_page.dart';
import 'package:audifie_version_1/features/settings/presenter/notifiers/settings_notifier.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/settings_page.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/service_locator.dart';
import 'core/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpServices();
  runApp(MyApp());
}

AudioService? audioService;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => PageSelectorNotifier(),
                ),
                ChangeNotifierProvider(
                  create: (_) => SettingsNotifier(),
                  child: SettingsPage(),
                ),
                ChangeNotifierProvider(
                  create: (_) => AuthNotifier(),
                ),
                ChangeNotifierProvider(
                  create: (_) => AudioDocNotifier(),
                  child: BaseHomePage(),
                ),
              ],
              child: MaterialApp(
                title: 'Audifie Version 1',
                onGenerateRoute: RouteGenerator.generateRoute,
                onGenerateInitialRoutes: RouteGenerator.generateInitialRoutes,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  accentColor: Palette.primary,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
