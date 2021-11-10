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
    progressState: 'COMPLETE',
    pages: [
      Strings.audioURL1,
      Strings.audioURL2,
    ],
    isFavourite: false,
  );

  static AudioDocModel _audioDocModel2 = AudioDocModel(
    fileId: '2',
    title: 'New audio from Droy',
    progressState: 'COMPLETE',
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
}
