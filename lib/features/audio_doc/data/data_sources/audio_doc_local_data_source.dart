import 'dart:io';

import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/file_picker_service.dart';

abstract class AudioDocLocalDataSource {
  Future<File?> pickFile();
}

class AudioDocLocalDataSourceImpl implements AudioDocLocalDataSource {
  final FilePickerService _filePickerService = sl<FilePickerService>();

  @override
  Future<File?> pickFile() async {
    return _filePickerService.pickFile();
  }
}
