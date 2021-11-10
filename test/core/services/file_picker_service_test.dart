import 'dart:io';

import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/file_picker_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../service_locator_test.dart';

@GenerateMocks([FilePicker])
void main() {
  setUpServicesForTest();

  final FilePicker mockFilePicker = sl<FilePicker>();
  final FilePickerService filePickerService = FilePickerServiceImpl();

  group('file picker service test', () {
    test('should return list of files when succeed', () async {
      final List<File> tFiles = [
        File('file/file.ext'),
      ];
      final FilePickerResult tFilePickerResult = FilePickerResult([PlatformFile(path: 'file/file.ext', name: 'file.ext', size: 1)]);

      when(mockFilePicker.pickFiles(allowMultiple: true)).thenAnswer((realInvocation) async => tFilePickerResult);
      final List<File>? result = await filePickerService.pickFiles();

      verify(mockFilePicker.pickFiles(allowMultiple: true));
      for (int i = 0; i < result!.length; i++)
        expect(result[i].path, tFiles[i].path);
    });

    test('should return null when user didn\'t select any file', () async {
      when(mockFilePicker.pickFiles(allowMultiple: true)).thenAnswer((realInvocation) async => null);
      final List<File>? result = await filePickerService.pickFiles();

      verify(mockFilePicker.pickFiles(allowMultiple: true));
      expect(result, null);
    });

    test('should throw exception when failed', () async {
      when(mockFilePicker.pickFiles(allowMultiple: true)).thenAnswer((realInvocation) async => throw Exception());

      expect(() async => await filePickerService.pickFiles(), throwsA(isA<Exception>()));
    });
  });
}