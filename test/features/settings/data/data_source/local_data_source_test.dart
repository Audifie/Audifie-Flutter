import 'dart:io';

import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/file_picker_service.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/service_locator_test.dart';

@GenerateMocks([FilePickerService])
void main() {
  setUpServicesForTest();

  final FilePickerService mockFilePickerService = sl<FilePickerService>();
  final SettingsLocalDataSource localDataSource = SettingsLocalDataSourceImpl();

  group('local data source test', () {
    test('should throw pick files exception when failed', () async {
      when(mockFilePickerService.pickFiles()).thenAnswer((realInvocation) => throw Exception('error'));

      expect(() async => localDataSource.pickFiles(), throwsA(isA<PickFilesException>()));
    });

    test('should throw pick files exception not picker by user', () async {
      when(mockFilePickerService.pickFiles()).thenAnswer((realInvocation) async => null);

      expect(() async => await localDataSource.pickFiles(), throwsA(isA<PickFilesException>()));
    });

    test('should return list of files when succeed', () async {
      final List<File> tFiles = [
        File(''),
      ];

      when(mockFilePickerService.pickFiles()).thenAnswer((realInvocation) async => tFiles);
      final List<File> result = await localDataSource.pickFiles();

      verify(mockFilePickerService.pickFiles());
      expect(result, tFiles);
    });
  });
}