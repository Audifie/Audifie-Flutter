import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../service_locator.dart';

abstract class FilePickerService {
  Future<List<File>?> pickFiles();
}

class FilePickerServiceImpl implements FilePickerService {
  final FilePicker filePicker = sl<FilePicker>();

  List<File> _platformFilesToFiles(List<PlatformFile> platformFiles) {
    return platformFiles.where((element) => element.path != null).map((e) => File(e.path!)).toList();
  } 

  @override
  Future<List<File>?> pickFiles() async {
    final FilePickerResult? result = await filePicker.pickFiles(allowMultiple: true);
    if (result == null)
      return null;
    return _platformFilesToFiles(result.files); 
  }
}