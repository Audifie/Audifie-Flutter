import 'dart:ui';

import 'package:audifie_version_1/core/utils/dummy_util.dart';
import 'package:audifie_version_1/core/widgets/image_placeholder.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/audio_doc_player_page.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/home_page.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/library_page.dart';
import 'package:audifie_version_1/features/page_selector/presenter/notifiers/page_selector_notifier.dart';
import 'package:audifie_version_1/features/premium/presenter/pages/premium_page.dart';
import 'package:audifie_version_1/features/settings/presenter/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/palette.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/service_locator.dart';
import '../../../../core/size_config.dart';
import '../../../../core/widgets/core_widgets.dart';

class BaseHomePage extends StatefulWidget {
  BaseHomePage({Key? key}) : super(key: key);

  @override
  _BaseHomePageState createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  final SizeConfig sc = sl<SizeConfig>();

  final List<BottomNavBarIconInfo> _pageInfoList = [
    BottomNavBarIconInfo(
      index: 0,
      title: 'Home',
      icon: Strings.homeIcon,
      widget: HomePage(),
    ),
    BottomNavBarIconInfo(
      index: 1,
      title: 'Library',
      icon: Strings.libraryIcon,
      widget: LibraryPage(),
    ),
    BottomNavBarIconInfo(
      index: 2,
      title: 'Premium',
      icon: Strings.premiumIcon,
      widget: PremiumPage(),
    ),
    BottomNavBarIconInfo(
      index: 3,
      title: 'Settings',
      icon: Strings.settingsIcon,
      widget: SettingsPage(),
    ),
  ];

  Widget _iconBtn({
    required BottomNavBarIconInfo iconInfo,
    required bool isSelected,
    required Function() onTap,
  }) {
    int index = iconInfo.index;
    final String icon = iconInfo.icon;
    final String title = iconInfo.title;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: sc.height(16),
            height: sc.height(16),
            color: isSelected
                ? Palette.primary
                : (index != 2)
                    ? Palette.secondaryText
                    : Palette.premiumBottomNavBar,
          ),
          SizedBox(height: sc.height(6)),
          Text(
            title,
            style: TStyle(
              color: isSelected
                  ? Palette.primary
                  : (index != 2)
                      ? Palette.secondaryText
                      : Palette.premiumBottomNavBar,
              size: sc.text(14),
            ),
          )
        ],
      ),
    );
  }

  bool _isPageSelected(int currentIndex, int index) {
    return currentIndex == index;
  }

  @override
  void initState() {
    super.initState();

    context.read<AudioDocNotifier>().getAllAudioDocsAndInit(context);
  }

  @override
  Widget build(BuildContext context) {
    final PageSelectorNotifier pageSelectorNotifier =
        context.watch<PageSelectorNotifier>();
    final int currentPageIndex = pageSelectorNotifier.currentPageIndex;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          _pageInfoList[currentPageIndex].widget,
          // TODO: Base audi player
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Consumer<AudioDocNotifier>(
                  builder: (context, notifier, child) {
                    return notifier.currentlyPlayingAudioDoc != null
                        ? GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AudioDocPlayerPage.routeName, arguments: notifier.currentlyPlayingAudioDoc!);
                          },
                          child: Container(
                              height: sc.height(111),
                              color: Palette.audioDocCardBg.withOpacity(.85),
                              padding: EdgeInsets.symmetric(
                                  vertical: sc.height(9),
                                  horizontal: sc.width(26)),
                              child: Row(
                                children: [
                                  Container(
                                    width: sc.width(61),
                                    child: notifier.currentlyPlayingAudioDoc!.imageURL != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(1)),
                                            child: Image.network(
                                                notifier.currentlyPlayingAudioDoc!.imageURL!,
                                                fit: BoxFit.cover),
                                          )
                                        : LayoutBuilder(
                                            builder: (_, constraints) {
                                              return ImagePlaceholder(
                                                width: constraints.maxWidth,
                                                height: constraints.maxHeight,
                                              );
                                            },
                                          ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notifier
                                              .currentlyPlayingAudioDoc!.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: TStyle(
                                            color: Palette.primaryText,
                                            size: sc.text(14),
                                          ),
                                        ),
                                        SizedBox(height: sc.height(12)),
                                        StreamBuilder<PlaybackStateInfo>(
                                          stream: context.read<AudioDocNotifier>().playbackStateStream,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.active) {
                                              return Text(
                                                'Page - ${(snapshot.data!.queueIndex != null) ? snapshot.data!.queueIndex! + 1 : 0}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TStyle(
                                                  color: Palette.secondaryText,
                                                  size: sc.text(12),
                                                ),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  _PlayButton(
                                      audioDoc:
                                          notifier.currentlyPlayingAudioDoc!),
                                ],
                              ),
                            ),
                        )
                        : const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: sc.height(76),
        color: Palette.bottomNavBar,
        child: Row(
          children: _pageInfoList.map((pageInfo) {
            return Expanded(
              child: _iconBtn(
                iconInfo: pageInfo,
                isSelected: _isPageSelected(currentPageIndex, pageInfo.index),
                onTap: () {
                  final int pageIndex = pageInfo.index;
                  pageSelectorNotifier.changePage(pageIndex);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavBarIconInfo {
  final int index;
  final String title;
  final String icon;
  final Widget widget;
  const BottomNavBarIconInfo({
    required this.index,
    required this.title,
    required this.icon,
    required this.widget,
  });
}

class _PlayButton extends StatelessWidget {
  final AudioDoc audioDoc;
  const _PlayButton({required this.audioDoc}) : super();

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackStateInfo>(
      stream: context.read<AudioDocNotifier>().playbackStateStream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          final bool isPlaying =
              (snapshot.data != null) ? snapshot.data!.isPlaying : false;
          return InkWell(
            onTap: () {
              // TODO: Player
              isPlaying
                  ? context.read<AudioDocNotifier>().pause()
                  : context.read<AudioDocNotifier>().play(audioDoc);
            },
            borderRadius: BorderRadius.circular(sc.height(100)),
            child: Icon(
              //TODO: ------
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: sc.height(34),
              color: Palette.primaryText,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
