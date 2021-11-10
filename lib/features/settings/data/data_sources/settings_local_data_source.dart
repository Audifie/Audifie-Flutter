import 'dart:io';

import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/file_picker_service.dart';

abstract class SettingsLocalDataSource {
  Future<List<File>> pickFiles(); 
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final FilePickerService filePickerService = sl<FilePickerService>(); 

  @override
  Future<List<File>> pickFiles() async {
    try {
      final List<File>? files = await filePickerService.pickFiles();
      if (files != null)
        return files;
      throw PickFilesException(message: Strings.fileNotPicked);
    } catch (e) {
      throw PickFilesException(message: e.toString());
    }
  }
}