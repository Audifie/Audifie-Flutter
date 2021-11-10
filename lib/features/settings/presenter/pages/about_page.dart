import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/settings/domain/entities/team_member_info.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';

import 'components/team_member_card.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/about_page';

  const AboutPage({Key? key}) : super(key: key);

  static const double _horizontalPadding = 34;

  static const String _about = "About";
  static const String _ourTeam = "Our Team";

  static SizeConfig sc = sl<SizeConfig>();

  static final List<TeamMemberInfo> _teamInfoList =
      List.generate(10, (index) {
    return TeamMemberInfo(
      name: "John Walker",
      title: "Title",
      email: "",
      linkedIn: "",
      twitter: "",
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IndependentAppBar(context: context),
      backgroundColor: Palette.bg,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                // SizedBox(height: sc.height(51)),
                // IndependentAppBarWidget(),
                SizedBox(height: sc.height(41)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Text(
                    _about,
                    style: TStyle(
                      color: Palette.primaryText,
                      size: sc.text(20),
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: sc.height(40)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Text(
                    Strings.lorem,
                    style: TStyle(
                      color: Palette.primaryText,
                      size: sc.text(16),
                    ).copyWith(height: sc.height(1.8)),
                  ),
                ),
                SizedBox(height: sc.height(40)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: Text(
                    _ourTeam,
                    style: TStyle(
                      color: Palette.primaryText,
                      size: sc.text(20),
                    ).copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: sc.height(24)),
              ] +
              _teamInfoList.map((teamMemberInfo) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                  child: TeamMemberCard(
                    teamMemberInfo: teamMemberInfo,
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
