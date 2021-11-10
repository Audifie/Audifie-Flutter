import 'package:audifie_version_1/features/audio_doc/domain/entities/audio_doc.dart';

class FavouriteAudioDocsPageUtil {
  static List<AudioDoc> getFavouriteAudioDocs(List<AudioDoc> audioDocs) {
    return audioDocs.where((element) => element.isFavourite).toList();
  }
}