import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/settings/domain/entities/team_member_info.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TeamMemberCard extends StatelessWidget {
  final TeamMemberInfo teamMemberInfo;
  const TeamMemberCard({Key? key, required this.teamMemberInfo})
      : super(key: key);

  static SizeConfig sc = sl<SizeConfig>();

  static Widget _emptyProfileImage = Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Palette.primary,
      borderRadius: BorderRadius.circular(sc.height(8)),
    ),
    child: SvgPicture.asset(
      Strings.audifieIcon,
      color: Palette.primaryText.withOpacity(.60),
      width: sc.height(30),
      height: sc.height(30),
    ),
  );

  static Widget _socialIconButton(BuildContext context, String icon, String url) {
    return GestureDetector(
      onTap: () {
        // TODO: Launch url
        // context.read<SettingsNotifier>().launchURL(url);
      },
      child: Container(
        width: sc.height(28),
        height: sc.height(28),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Palette.settingsBtn.withOpacity(.20),
          borderRadius: BorderRadius.circular(sc.height(2)),
        ),
        child: SvgPicture.asset(
          icon,
          width: sc.width(14),
          height: sc.height(14),
          color: Palette.primaryText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String? imageURL = teamMemberInfo.imageURL;
    final String name = teamMemberInfo.name;
    final String title = teamMemberInfo.title;
    final String? email = teamMemberInfo.email;
    final String? linkedIn = teamMemberInfo.linkedIn;
    final String? twitter = teamMemberInfo.twitter;

    final double size = .36 * MediaQuery.of(context).size.width;

    return Container(
      height: size,
      margin: EdgeInsets.only(bottom: sc.height(70)),
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sc.height(8)),
            ),
            child: imageURL != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(sc.height(8)),
                    child: Image.asset(
                      imageURL,
                      fit: BoxFit.cover,
                    ),
                  )
                : _emptyProfileImage,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: sc.width(28),
                top: sc.height(8),
                bottom: sc.height(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TStyle(
                      color: Palette.primaryText,
                      size: sc.text(16),
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: sc.height(8)),
                  Text(
                    title,
                    style: TStyle(
                      color: Palette.primaryText,
                      size: sc.text(16),
                    ).copyWith(fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      email != null ? _socialIconButton(context, Strings.emailIcon, "https://pub.dev/packages/url_launcher") : SizedBox(),
                      email != null ? SizedBox(width: sc.width(22)) : SizedBox(),
                      linkedIn != null ? _socialIconButton(context, Strings.linkedInIcon, "https://pub.dev/packages/url_launcher") : SizedBox(),
                      linkedIn != null ? SizedBox(width: sc.width(22)) : SizedBox(),
                      twitter != null ? _socialIconButton(context, Strings.twitterIcon, "https://pub.dev/packages/url_launcher") : SizedBox(),
                    ],
                  ),
                  SizedBox(height: sc.height(8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
