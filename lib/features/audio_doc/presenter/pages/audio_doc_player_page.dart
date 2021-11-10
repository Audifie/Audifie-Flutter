import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AudioDocPlayerPage extends StatefulWidget {
  static const String routeName = 'audio_doc_player_page';

  final AudioDoc audioDoc;
  AudioDocPlayerPage({Key? key, required this.audioDoc}) : super(key: key);

  @override
  _AudioDocPlayerPageState createState() => _AudioDocPlayerPageState();
}

class _AudioDocPlayerPageState extends State<AudioDocPlayerPage> {
  static const double _horizontalPadding = 34;
  static const String _pageNo = "Page No.";
  static const String _oneX = "1x";
  static const String _oneHalfX = "1.5x";
  static const String _twoX = "2x";

  static const double _oneXSpeed = 1;
  static const double _oneHalfXSpeed = 1.5;
  static const double _twoXSpeed = 2;

  static SizeConfig sc = sl<SizeConfig>();

  static Widget _emptyImage = Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(sc.height(5)),
      color: Palette.primary,
    ),
    child: SvgPicture.asset(
      Strings.audifieIcon,
      width: sc.height(60),
      height: sc.height(60),
      color: Palette.primaryText.withOpacity(.60),
    ),
  );

  // static Widget _skipButton(
  //     BuildContext context, bool skipNext, bool isEnabled) {
  //   return InkWell(
  //     onTap: isEnabled
  //         ? () {
  //             skipNext
  //                 ? context.read<AudioDocNotifier>().skipToNext()
  //                 : context.read<AudioDocNotifier>().skipToPrevious();
  //           }
  //         : null,
  //     borderRadius: BorderRadius.circular(sc.height(100)),
  //     child: Container(
  //       height: sc.height(64),
  //       width: sc.height(64),
  //       alignment: Alignment.center,
  //       child: Icon(
  //         skipNext ? Icons.skip_next : Icons.skip_previous,
  //         size: sc.height(34),
  //         color: isEnabled
  //             ? Palette.primaryText
  //             : Palette.primaryText.withOpacity(.60),
  //       ),
  //     ),
  //   );
  // }

  static Widget _speedButton(BuildContext context, double? currentSpeed) {
    String speedText = _oneX;
    if (currentSpeed == _oneHalfXSpeed) {
      speedText = _oneHalfX;
    } else if (currentSpeed == _twoXSpeed) {
      speedText = _twoX;
    }
    return InkWell(
      onTap: () async {
        double speed = _oneXSpeed;

        if (currentSpeed == _oneXSpeed) {
          speed = _oneHalfXSpeed;
        } else if (currentSpeed == _oneHalfXSpeed) {
          speed = _twoXSpeed;
        }

        context.read<AudioDocNotifier>().setSpeed(speed);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: sc.width(8),
          vertical: sc.height(4),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sc.height(2)),
            color: Palette.primaryText),
        child: Text(
          speedText,
          style: TStyle(
            color: Colors.black,
            size: sc.height(14),
          ).copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  late Duration _totalDuration;

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

    final AudioDoc? currentlyPlayingAudioDoc =
        context.read<AudioDocNotifier>().currentlyPlayingAudioDoc;

    if (currentlyPlayingAudioDoc != null) {
      if (currentlyPlayingAudioDoc.fileId != widget.audioDoc.fileId) {
        // context
        //     .read<AudioDocNotifier>()
        //     .loadPlaylist(widget.audioDoc);
        _loadNewPlaylistAndPlay();
      }
    } else {
      // context
      //     .read<AudioDocNotifier>()
      //     .loadPlaylist(widget.audioDoc);
      _loadPlaylistAndPlay();
    }

    context.read<AudioDocNotifier>().durationStream.listen((duration) {
      _totalDuration = duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.audioDoc.title;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Palette.bg,
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: sc.width(8)),
                alignment: Alignment.center,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: sc.height(32),
                  color: Palette.primaryText,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  // TODO: Favourite function
                  // final String idToken = context
                  //     .read<PageSelectorNotifier>()
                  //     .authSession!
                  //     .userPoolTokens
                  //     .idToken;
                  // !widget.audioDocModel.isFavourite
                  //     ? context
                  //         .read<UploadNotifier>()
                  //         .addFavourite(widget.audioDocModel, idToken)
                  //     : context
                  //         .read<UploadNotifier>()
                  //         .removeFavourite(widget.audioDocModel, idToken);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: sc.width(20)),
                  alignment: Alignment.center,
                  child: Icon(
                    widget.audioDoc.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: sc.height(20),
                    color: Palette.primaryText,
                  ),
                ),
              ),
            ],
            elevation: sc.height(0),
            // toolbarHeight: sc.height(64),
            backgroundColor: Palette.bg,
            title: Text(
              title,
              style: TStyle(
                color: Palette.primaryText,
                size: sc.text(18),
              ).copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: sc.width(_horizontalPadding)),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(sc.height(5)),
                    ),
                    child: widget.audioDoc.imageUrl != null
                        ? Image.network(widget.audioDoc.imageUrl!,
                            fit: BoxFit.cover)
                        : _emptyImage,
                  ),
                ),
                SizedBox(height: sc.height(36)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Skip to previous
                    SkipButton(isSkipNext: false),
                    // Play and Pause Button
                    PlayButton(audioDoc: widget.audioDoc),
                    // Skip to next
                    SkipButton(isSkipNext: true),
                  ],
                ),
                SizedBox(height: sc.height(34)),
                // Page no., Page Selector, Speed Selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      _pageNo,
                      style: TStyle(
                        color: Palette.primaryText,
                        size: sc.text(14),
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: sc.width(12)),
                    StreamBuilder<PlaybackStateInfo>(
                        stream: context
                            .read<AudioDocNotifier>()
                            .playbackStateStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return Text(
                              snapshot.data!.queueIndex != null
                                  ? '${snapshot.data!.queueIndex! + 1}'
                                  : '',
                              style: TStyle(
                                color: Palette.secondaryText,
                                size: sc.text(14),
                              ).copyWith(fontWeight: FontWeight.w500),
                            );
                          }
                          return const SizedBox();
                        }),
                    SizedBox(width: sc.width(12)),
                    Text(
                      '/',
                      style: TStyle(
                        color: Palette.secondaryText,
                        size: sc.text(14),
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: sc.width(12)),
                    Text(
                      '${widget.audioDoc.pages.length}',
                      style: TStyle(
                        color: Palette.secondaryText,
                        size: sc.text(14),
                      ).copyWith(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    StreamBuilder<double>(
                      stream: context.read<AudioDocNotifier>().speedStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          return _speedButton(context, snapshot.data);
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
                SizedBox(height: sc.height(36)),
                StreamBuilder<Duration>(
                  stream: context.read<AudioDocNotifier>().positionStream,
                  builder: (_, snapshot) {
                    if (snapshot.data != null) {
                      return Slider.adaptive(
                        activeColor: Palette.primary,
                        inactiveColor: const Color(0xffCCCCCC),
                        min: 0,
                        max: _totalDuration.inSeconds.toDouble(),
                        value: snapshot.data!.inSeconds.toDouble(),
                        onChanged: (value) {
                          context
                              .read<AudioDocNotifier>()
                              .seek(Duration(seconds: value.toInt()));
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
                SizedBox(height: sc.height(40)),
              ],
            ),
          ),
        ),
        // TODO: Loading
        // Selector<UploadNotifier, bool>(
        //   selector: (_, audioPlayerNotifier) => audioPlayerNotifier.isLoading,
        //   builder: (_, isLoading, __) {
        //     return isLoading ? LoadingWidget() : AbsorbPointer();
        //   },
        // ),
      ],
    );
  }
}

class PlayButton extends StatelessWidget {
  final AudioDoc audioDoc;
  const PlayButton({Key? key, required this.audioDoc}) : super(key: key);

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
            child: Container(
              height: sc.height(64),
              width: sc.height(64),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Palette.primaryText,
                shape: BoxShape.circle,
              ),
              child: Icon(
                //TODO: ------
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: sc.height(34),
                color: Palette.bg,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class SkipButton extends StatelessWidget {
  final bool isSkipNext;
  const SkipButton({required this.isSkipNext});

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackStateInfo>(
      stream: context.read<AudioDocNotifier>().playbackStateStream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return InkWell(
            onTap: isSkipNext
                ? context.read<AudioDocNotifier>().skipToNext
                : context.read<AudioDocNotifier>().skipToPrevious,
            borderRadius: BorderRadius.circular(sc.height(100)),
            child: Container(
              height: sc.height(64),
              width: sc.height(64),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSkipNext ? Icons.skip_next : Icons.skip_previous,
                size: sc.height(34),
                color: Palette.primaryText,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
