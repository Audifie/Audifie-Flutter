import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/features/audio_doc/data/models/audio_doc_model.dart';
import 'package:audifie_version_1/features/settings/domain/entities/profile_info.dart';

class DummyUtil {
  static ProfileInfo profileInfo = ProfileInfo(
    email: 'droy@gmail.com',
    name: 'Dhritiman Roy',
  );

  static AudioDocModel _audioDocModel1 = AudioDocModel(
    fileId: '1',
    title: 'Audio 1',
    isProcessing: false,
    pages: [
      Strings.audioURL1,
      Strings.audioURL2,
    ],
    isFavourite: false,
  );

  static AudioDocModel _audioDocModel2 = AudioDocModel(
    fileId: '2',
    title: 'New audio from Droy',
    isProcessing: false,
    pages: [
      Strings.audioURL2,
      Strings.audioURL1,
    ],
    isFavourite: false,
  );

  static List<AudioDocModel> audioDocModels = [
    _audioDocModel1,
    _audioDocModel2,
  ];

  static const String dummyAudioText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum';
}
