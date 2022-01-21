import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/core/widgets/loading_widget.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/notifiers/audio_doc_notifier.dart';
import 'package:audifie_version_1/features/audio_doc/presenter/pages/components/all_docs_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'components/favourite_audio_docs_page.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  static const String _allDoc = "All documents";
  static const String _fav = "Favourites";

  static final SizeConfig sc = sl<SizeConfig>();

  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final double dialogHeight = .62 * MediaQuery.of(context).size.height;

    final AudioDocNotifier audioDocNotifier = context.watch<AudioDocNotifier>();

    return Stack(
      children: [
        DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: BaseAppBar(context: context),
            backgroundColor: Palette.bg,
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController!,
                    isScrollable: false,
                    indicatorColor: Palette.primary,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: sc.width(20)),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: sc.height(4),
                    tabs: [
                      Tab(
                        child: Text(
                          _allDoc,
                          style: TStyle(
                            color: Palette.primaryText,
                            size: sc.text(18),
                            font: Strings.comfortaaFont,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Strings.favouriteOutlineIcon,
                              width: sc.width(16),
                              height: sc.height(14),
                              color: Palette.primaryText,
                            ),
                            SizedBox(width: sc.width(20)),
                            Text(
                              _fav,
                              style: TStyle(
                                color: Palette.primaryText,
                                size: sc.text(18),
                                font: Strings.comfortaaFont,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController!,
                      children: [
                        AllDocsPage(),
                        FavouriteAudioDocsPage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Consumer<AudioDocNotifier>(
              builder: (context, notifier, child) {
                return FloatingActionButton(
                  backgroundColor: Palette.primary,
                  onPressed: !notifier.isUploadingFile ? () {
                    context.read<AudioDocNotifier>().uploadAudioDoc(context);
                  } : () {},
                  child: !notifier.isUploadingFile
                      ? SvgPicture.asset(
                          Strings.uploadIcon,
                          width: sc.width(19),
                          height: sc.height(20),
                          color: Palette.primaryText,
                        )
                      : SizedBox(
                          height: sc.height(20),
                          width: sc.height(20),
                          child: CircularProgressIndicator(
                            backgroundColor: Palette.primaryText,
                          ),
                        ),
                );
              },
            ),
          ),
        ),
        audioDocNotifier.isLoading ? LoadingWidget() : AbsorbPointer(),
      ],
    );
  }
}
