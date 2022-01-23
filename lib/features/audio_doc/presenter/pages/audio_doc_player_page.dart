import 'dart:io';

import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/utils/dummy_util.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';
import 'package:audifie_version_1/features/audio_doc/domain/entities/playback_state_info.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

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
  String _speechText = '-- Speech Text --';

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

  void _combineSpeechText() {
    String totalText = '';
    widget.audioDoc.speechMarks.forEach((element) {
      totalText = totalText + element!['value'];
    });
    _speechText = totalText;
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

    _combineSpeechText();
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
                // TODO: VoiceChange function
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: sc.width(10)),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  Strings.voiceChangeIcon,
                  fit: BoxFit.contain,
                  color: Palette.primaryText,
                ),
              ),
            ),

            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: sc.width(8)),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.fullscreen_exit,
                    size: sc.height(32),
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
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      border: Border.all(color: Palette.textFieldBorder),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      // widget.audioDoc.subtitles,
                      // TODO: Extract text from speechURL
                      _speechText,
                      maxLines: 18,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: sc.text(18),
                        color: Palette.primaryText,
                      ),
                    ),
                  ),
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
                SizedBox(height: sc.height(36)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Favorite
                    IsFavoriteButton(
                      audioDoc: widget.audioDoc,
                      onPressed: () {
                        setState(() {
                          context.read<AudioDocNotifier>().changeFavouriteTo(
                              context,
                              widget.audioDoc,
                              !widget.audioDoc.isFavourite);
                        });
                      },
                    ),
                    // Skip to previous
                    // SkipButton(isSkipNext: false),
                    // Fast forward
                    Forward(isFastForward: false),
                    // Play and Pause Button
                    PlayButton(audioDoc: widget.audioDoc),
                    // Skip to next
                    // SkipButton(isSkipNext: true),
                    // Rewind
                    Forward(isFastForward: true),
                    // Speed Button
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
                SizedBox(height: sc.height(50)),
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

class Forward extends StatelessWidget {
  final bool isFastForward;
  const Forward({required this.isFastForward});

  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackStateInfo>(
      stream: context.read<AudioDocNotifier>().playbackStateStream,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return InkWell(
            onTap: isFastForward
                ? context.read<AudioDocNotifier>().fastForward
                : context.read<AudioDocNotifier>().rewind,
            borderRadius: BorderRadius.circular(sc.height(100)),
            child: Container(
              height: sc.height(64),
              width: sc.height(64),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFastForward ? Icons.fast_forward : Icons.fast_rewind,
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

class IsFavoriteButton extends StatelessWidget {
  final AudioDoc audioDoc;
  final Function()? onPressed;
  const IsFavoriteButton({Key? key, required this.audioDoc, this.onPressed})
      : super(key: key);
  static SizeConfig sc = sl<SizeConfig>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          audioDoc.isFavourite ? Icons.favorite : Icons.favorite_border,
          size: sc.height(30),
          color: Palette.primaryText,
        ),
      ),
    );
  }
}
