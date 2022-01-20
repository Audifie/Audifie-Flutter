import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/utils/audio_doc_card_util.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/audio_doc_player_page.dart';
import 'package:audifie_version_1/core/widgets/image_placeholder.dart';
import '../../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AudioDocCard extends StatefulWidget {
  final AudioDoc audioDoc;
  const AudioDocCard({Key? key, required this.audioDoc}) : super(key: key);

  @override
  _AudioDocCardState createState() => _AudioDocCardState();
}

class _AudioDocCardState extends State<AudioDocCard> {
  static const String _hrsListen = "Hours Listen";
  static const String _play = "PLAY";
  static const String _downloadFile = "Download File";
  static const String _delete = "Delete";
  static const String _fav = "Favourite";
  static const String _close = "Close";

  static SizeConfig sc = sl<SizeConfig>();

  bool _isMoreOpen = false;

  static String _hoursListen(double hours) {
    if (hours % 1 == 0) {
      return hours.round().toString();
    } else {
      return hours.toString();
    }
  }

  static Widget _moreItem(String icon, String title, Function() onTap) {
    return Material(
      color: Palette.audioDocCardBg,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: sc.width(20),
            vertical: sc.height(16),
          ),
          child: Row(
            children: [
              SvgPicture.asset(icon,
                  width: sc.width(16),
                  height: sc.height(16),
                  color: Palette.primaryText.withOpacity(.70)),
              SizedBox(width: sc.width(16)),
              Text(
                title,
                style: TStyle(
                  color: Palette.primaryText.withOpacity(.70),
                  size: sc.text(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _divider = Divider(
    color: Palette.settingsBtn.withOpacity(.40),
    thickness: sc.height(1),
    height: 1,
  );

  void _loadNewPlaylistAndPlay() async {
    await context.read<AudioDocNotifier>().stop();
    await context.read<AudioDocNotifier>().loadPlaylist(widget.audioDoc);
    context.read<AudioDocNotifier>().play(widget.audioDoc);
  }

  void _loadPlaylistAndPlay() async {
    await context.read<AudioDocNotifier>().loadPlaylist(widget.audioDoc);
    context.read<AudioDocNotifier>().play(widget.audioDoc);
  }

  @override
  void initState() {
    super.initState();

    _isMoreOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.audioDoc.title;

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await context.read<AudioDocNotifier>().getAudioDoc(context, widget.audioDoc);
            Navigator.pushNamed(context, AudioDocPlayerPage.routeName,
                arguments: widget.audioDoc);
          },
          child: Container(
            height: .56 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Palette.audioDocCardBg,
              borderRadius: BorderRadius.circular(sc.height(5)),
            ),
            child: Row(
              children: [
                // Doc Image
                Expanded(
                  flex: 44,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sc.width(4),
                      vertical: sc.height(4),
                    ),
                    child: widget.audioDoc.imageURL != null
                        ? Image.network(widget.audioDoc.imageURL!)
                        : LayoutBuilder(
                            builder: (_, constraints) => ImagePlaceholder(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                            ),
                          ),
                  ),
                ),
                // Doc Info
                Expanded(
                  flex: 56,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sc.width(24),
                      vertical: sc.height(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          title,
                          style: TStyle(
                            color: Palette.primaryText,
                            size: sc.text(16),
                            isBold: true,
                          ),
                        ),
                        SizedBox(height: sc.height(26)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Hours listen
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sc.width(14),
                                      vertical: sc.height(6)),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(sc.height(50)),
                                    border: Border.all(
                                      color: Palette.primaryText,
                                      width: sc.height(1),
                                    ),
                                  ),
                                  child: Text(
                                    AudioDocCardUtil.durationToString(
                                        widget.audioDoc.duration),
                                    style: TStyle(
                                            color: Palette.primaryText,
                                            size: 10)
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: sc.width(4)),
                            // Favourite Button
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  widget.audioDoc.isFavourite
                                      ? context
                                          .read<AudioDocNotifier>()
                                          .changeFavouriteTo(
                                              context, widget.audioDoc, false)
                                      : context
                                          .read<AudioDocNotifier>()
                                          .changeFavouriteTo(
                                              context, widget.audioDoc, true);
                                },
                                borderRadius:
                                    BorderRadius.circular(sc.height(50)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sc.height(6),
                                      vertical: sc.height(6)),
                                  child: SvgPicture.asset(
                                    widget.audioDoc.isFavourite
                                        ? Strings.favouriteIcon
                                        : Strings.favouriteOutlineIcon,
                                    width: sc.width(20),
                                    height: sc.height(18),
                                    color: Palette.primaryText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Consumer<AudioDocNotifier>(
                              builder: (context, notifier, child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    await context.read<AudioDocNotifier>().getAudioDoc(context, widget.audioDoc);
                                    // TODO: Play button function
                                    if (notifier.currentlyPlayingAudioDoc !=
                                        null) {
                                      _loadNewPlaylistAndPlay();
                                    } else {
                                      _loadPlaylistAndPlay();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: sc.width(36),
                                      vertical: sc.height(14),
                                    ),
                                    primary: Palette.primaryText,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(sc.height(50)),
                                    ),
                                  ),
                                  child: child,
                                );
                              },
                              child: Text(
                                _play,
                                style: TStyle(
                                  color: Palette.audioDocCardBg,
                                  size: sc.text(14),
                                ).copyWith(fontWeight: FontWeight.w500),
                              ),
                            ),
                            // More Button
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isMoreOpen = !_isMoreOpen;
                                  });
                                },
                                borderRadius:
                                    BorderRadius.circular(sc.height(50)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sc.height(6),
                                      vertical: sc.height(6)),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Palette.primaryText,
                                    size: sc.height(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // More items menu
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          width: MediaQuery.of(context).size.width,
          height: _isMoreOpen ? (sc.height(4 * 52)) : 0,
          decoration: BoxDecoration(
            color: Palette.audioDocCardBg,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(sc.height(5)),
              bottomRight: Radius.circular(sc.height(5)),
            ),
          ),
          child: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 300)),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(sc.height(5)),
                    bottomRight: Radius.circular(sc.height(5)),
                  ),
                  child: Column(
                    children: [
                      _moreItem(
                        Strings.downloadIcon,
                        _downloadFile,
                        () {
                          // TODO: Download function
                          // context.read<UploadNotifier>().downalodFile(
                          //       widget.audioDocModel,
                          //       Hive.box(Strings.filePathsBox),
                          //     );
                        },
                      ),
                      _divider,
                      _moreItem(
                        Strings.deleteIcon,
                        _delete,
                        () {
                          // TODO: Delete function
                          // final String idToken = context
                          //     .read<PageSelectorNotifier>()
                          //     .authSession!
                          //     .userPoolTokens
                          //     .idToken;
                          // context.read<UploadNotifier>().deleteAudioDocModel(
                          //     widget.audioDocModel, idToken);
                        },
                      ),
                      _divider,
                      _moreItem(
                        widget.audioDoc.isFavourite
                            ? Strings.favouriteIcon
                            : Strings.favouriteOutlineIcon,
                        _fav,
                        () {
                          widget.audioDoc.isFavourite
                              ? context
                                  .read<AudioDocNotifier>()
                                  .changeFavouriteTo(
                                      context, widget.audioDoc, false)
                              : context
                                  .read<AudioDocNotifier>()
                                  .changeFavouriteTo(
                                      context, widget.audioDoc, true);
                        },
                      ),
                      _divider,
                      _moreItem(
                        Strings.clearIcon,
                        _close,
                        () {
                          setState(() {
                            _isMoreOpen = false;
                          });
                        },
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
        SizedBox(height: sc.height(34)),
      ],
    );
  }
}
