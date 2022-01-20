import 'package:audifie_version_1/features/audio_doc/data/data_sources/audio_doc_remote_data_source.dart';
import 'package:audifie_version_1/features/authentication/presenter/notifiers/auth_notifier.dart';
import 'package:audifie_version_1/features/authentication/presenter/pages/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/page_selector/presenter/pages/base_home_page.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();

    context.read<AuthNotifier>().getCurrentUser();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AudioDocRemoteDataSourceImpl().getAudioDoc('61dd9e3d51ec5d0a34b5f15f');
            // AudioDocRemoteDataSourceImpl().getAllAudioDocs();
          },
          child: Text('get audio doc details test'),
        ),
      ),
    );

    return Consumer<AuthNotifier>(
      builder: (_, notifier, child) {
        return notifier.isAuthDone ? BaseHomePage() : AuthWrapper();
      },
      // child: AuthWrapper(),
    );
  }
}
