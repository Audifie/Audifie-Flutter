import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/audio_doc_player_page.dart';
import 'package:audifie_version_1/features/authentication/domain/entities/sign_up_info.dart';
import 'package:audifie_version_1/features/authentication/presenter/pages/otp_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/about_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/change_password_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/privacy_policy_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/settings_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/support_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/transections_page.dart';
import 'package:audifie_version_1/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Widget _errorPage() {
    return Scaffold(
      backgroundColor: Palette.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 32, color: Palette.primary),
            Text(
              'Error page',
              style: TStyle(
                color: Palette.primaryText,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AudioDocPlayerPage.routeName:
        if (settings.arguments is AudioDoc) 
          return MaterialPageRoute(builder: (_) => AudioDocPlayerPage(audioDoc: settings.arguments as AudioDoc));
        return MaterialPageRoute(builder: (_) => _errorPage());
      case OtpPage.routeName:
        return MaterialPageRoute(builder: (_) => OtpPage(signUpInfo: settings.arguments as SignUpInfo));
      case SettingsPage.routeName:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case ChangePasswordPage.routeName:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      case TransectionsPage.routeName:
        return MaterialPageRoute(builder: (_) => TransectionsPage());
      case SupportPage.routeName:
        return MaterialPageRoute(builder: (_) => SupportPage());
      case PrivacyPolicyPage.routeName:
        return MaterialPageRoute(builder: (_) => PrivacyPolicyPage());
      case AboutPage.routeName:
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return MaterialPageRoute(builder: (_) => _errorPage());
    }
  }

  static List<Route<dynamic>> generateInitialRoutes(String routeName) {
    return [MaterialPageRoute(builder: (_) => Wrapper())];
  }
}
