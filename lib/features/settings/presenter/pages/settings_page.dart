import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/utils/dummy_util.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/authentication/presenter/notifiers/auth_notifier.dart';
import 'package:audifie_version_1/features/settings/domain/entities/profile_info.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/about_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/change_password_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/privacy_policy_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/support_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/transections_page.dart';

import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings_page';

  const SettingsPage({Key? key}) : super(key: key);

  static const String _free = 'Free';
  static const String _editProfile = 'Edit Profile';
  static const String _changePassword = 'Change Password';
  static const String _transections = 'Transections';
  static const String _support = 'Support';
  static const String _privacyTerms = 'Privacy & Terms';
  static const String _about = 'About';
  static const String _logout = 'Logout';

  static const double _horizontalPadding = 28;

  static SizeConfig sc = sl<SizeConfig>();

  static Widget _emptyProfileImage = Container(
    width: sc.height(96),
    height: sc.height(96),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Palette.primary,
      borderRadius: BorderRadius.circular(sc.height(50)),
    ),
    child: SvgPicture.asset(
      Strings.audifieIcon,
      color: Palette.primaryText.withOpacity(.60),
      width: sc.height(30),
      height: sc.height(30),
    ),
  );

  static Widget _profileCard(ProfileInfo profileInfo) {
    final String? imageURL = profileInfo.imageUrl;
    final String email = profileInfo.email;
    final String name = profileInfo.name ?? "";
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Palette.settingsProfileCardPg,
            borderRadius: BorderRadius.circular(sc.height(15)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, sc.height(5)),
                blurRadius: sc.height(10),
                color: Colors.black.withOpacity(.15),
              ),
            ],
          ),
          child: Row(
            children: [
              // Profile image
              Padding(
                padding: EdgeInsets.only(
                  left: sc.width(26),
                  top: sc.height(22),
                  bottom: sc.height(22),
                  right: sc.width(21),
                ),
                child: imageURL != null
                    ? SizedBox(
                        width: sc.height(96),
                        height: sc.height(96),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(sc.height(50)),
                          child: Image.network(imageURL, fit: BoxFit.cover),
                        ),
                      )
                    : _emptyProfileImage,
              ),
              // Name and Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TStyle(
                      color: Palette.secondaryText,
                      size: sc.text(16),
                      isBold: true,
                    ),
                  ),
                  SizedBox(height: sc.height(20)),
                  Text(
                    email,
                    style: TStyle(
                      color: Palette.secondaryText,
                      size: sc.text(14),
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
        // Free or Premium
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(right: sc.width(21)),
            padding: EdgeInsets.symmetric(
              horizontal: sc.width(8),
              vertical: sc.height(3),
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Palette.primaryText,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(sc.height(3)),
                bottomRight: Radius.circular(sc.height(3)),
              ),
            ),
            child: Text(
              _free,
              style: TStyle(color: Colors.black, size: sc.text(14)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _button({
    required String icon,
    required String title,
    required Function() onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(sc.height(8)),
        onTap: onTap,
        child: Container(
          height: sc.height(98),
          padding: EdgeInsets.only(top: sc.height(26), bottom: sc.height(11)),
          decoration: BoxDecoration(
            color: Palette.settingsBtn.withOpacity(.20),
            borderRadius: BorderRadius.circular(sc.height(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                icon,
                color: Palette.primaryText,
                width: sc.width(29),
                height: sc.height(28),
              ),
              Text(
                title,
                style: TStyle(color: Palette.primaryText, size: sc.text(14)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _logoutBtn(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(sc.height(8)),
        onTap: () {
          // TODO: Sign out functionality
          context.read<AuthNotifier>().signOut(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width - (2 * _horizontalPadding),
          height: sc.height(60),
          padding: EdgeInsets.symmetric(vertical: sc.height(18)),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Palette.settingsBtn.withOpacity(.40),
            borderRadius: BorderRadius.circular(sc.height(8)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Strings.logoutIcon,
                color: Palette.primaryText,
                width: sc.width(29),
                height: sc.height(28),
              ),
              SizedBox(width: sc.width(22)),
              Text(
                _logout,
                style: TStyle(color: Palette.primaryText, size: sc.text(18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // TODO: When settings loading don't allow to go back
          // return !settingsNotifier.isLoading;
          return true;
        },
        child: Scaffold(
          appBar: BaseAppBar(context: context),
          backgroundColor: Palette.bg,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: sc.width(_horizontalPadding)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      // SizedBox(height: sc.height(51)),
                      // SvgPicture.asset(
                      //   Strings.audifieTextIcon,
                      //   color: Palette.primary,
                      //   width: sc.width(111),
                      //   height: sc.height(24),
                      // ),
                      SizedBox(height: sc.height(32)),
                      _profileCard(DummyUtil.profileInfo),
                      SizedBox(height: sc.height(47)),
                      // Buttons
                      Row(
                        children: [
                          // Edit
                          Expanded(
                            child: _button(
                              icon: Strings.editIcon,
                              title: _editProfile,
                              onTap: () {},
                            ),
                          ),
                          SizedBox(width: sc.width(14)),
                          // Change password
                          Expanded(
                            child: _button(
                              icon: Strings.passwordIcon,
                              title: _changePassword,
                              onTap: () {
                                Navigator.pushNamed(context, ChangePasswordPage.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sc.height(15)),
                      Row(
                        children: [
                          // Transections
                          Expanded(
                            child: _button(
                              icon: Strings.historyIcon,
                              title: _transections,
                              onTap: () {
                                Navigator.pushNamed(context, TransectionsPage.routeName);
                              },
                            ),
                          ),
                          SizedBox(width: sc.width(14)),
                          // Support
                          Expanded(
                            child: _button(
                              icon: Strings.supportIcon,
                              title: _support,
                              onTap: () {
                                Navigator.pushNamed(context, SupportPage.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sc.height(15)),
                      Row(
                        children: [
                          // Privacy and Terms
                          Expanded(
                            child: _button(
                              icon: Strings.privacyIcon,
                              title: _privacyTerms,
                              onTap: () {
                                Navigator.pushNamed(context, PrivacyPolicyPage.routeName);
                              },
                            ),
                          ),
                          SizedBox(width: sc.width(14)),
                          // About
                          Expanded(
                            child: _button(
                              icon: Strings.aboutIcon,
                              title: _about,
                              onTap: () {
                                Navigator.pushNamed(context, AboutPage.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: sc.height(57)),
                      // Logout
                      _logoutBtn(context),
                      SizedBox(height: sc.height(200)),
                    ],
                  ),
                ),
              ),
              // TODO: Loading
              // settingsNotifier.isLoading ? LoadingWidget() : AbsorbPointer(),
            ],
          ),
        ),
      );
  }
}
