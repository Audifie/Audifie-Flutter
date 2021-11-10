import 'dart:io';

import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:audifie_version_1/features/settings/domain/usecases/file_picker_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/service_locator_test.dart';

@GenerateMocks([SettingsRepo])
void main() {
  setUpServicesForTest();

  final SettingsRepo mockSettingsRepo = sl<SettingsRepo>();
  final FilePickerUsecase filePickerUsecase = FilePickerUsecase();

  group('file picker usecase', () {
    test('should return failure if failed', () async {
      final Failure tPickFilesFailure = PickFilesFailure(message: 'error');

      when(mockSettingsRepo.pickFiles()).thenAnswer((realInvocation) async => Left(tPickFilesFailure));
      final Either<Failure, List<File>> result = await filePickerUsecase.pickFiles();

      verify(mockSettingsRepo.pickFiles());
      expect(result, Left(tPickFilesFailure));
    });

    test('should return list of files if succeed', () async {
      final List<File> tFiles = [
        File('path'),
      ];

      when(mockSettingsRepo.pickFiles()).thenAnswer((realInvocation) async => Right(tFiles));
      final Either<Failure, List<File>> result = await filePickerUsecase.pickFiles();

      verify(mockSettingsRepo.pickFiles());
      expect(result, Right(tFiles));
    });
  });
}