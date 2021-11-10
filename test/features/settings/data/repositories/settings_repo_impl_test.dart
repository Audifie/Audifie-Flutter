import 'dart:io';

import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:audifie_version_1/features/settings/data/models/email_info_model.dart';
import 'package:audifie_version_1/features/settings/data/repositories/settings_repo_impl.dart';
import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/service_locator_test.dart';

@GenerateMocks([SettingsLocalDataSource, SettingsRemoteDataSource])
void main() {
  setUpServicesForTest();

  final SettingsLocalDataSource mockLocalDataSource = sl<SettingsLocalDataSource>();
  final SettingsRemoteDataSource mockRemoteDataSource = sl<SettingsRemoteDataSource>();
  final SettingsRepo settingsRepo = SettingsRepoImpl();

  group('pick file', () {
    test('should return pick files failure when failed', () async {
      final Exception tException = PickFilesException(message: 'error');

      when(mockLocalDataSource.pickFiles()).thenAnswer((realInvocation) => throw tException);
      final Either<Failure, List<File>> result = await settingsRepo.pickFiles(); 

      verify(mockLocalDataSource.pickFiles());
      expect(result, Left(PickFilesFailure(message: 'error')));
    });

    test('should return list of files when succeed', () async {
      final List<File> tFiles = [
        File('path'),
      ];

      when(mockLocalDataSource.pickFiles()).thenAnswer((realInvocation) async => tFiles);
      final Either<Failure, List<File>> result = await settingsRepo.pickFiles(); 

      verify(mockLocalDataSource.pickFiles());
      expect(result, Right(tFiles));
    });
  });

  group('send email', () {
    final EmailInfoModel tEmailInfoModel = EmailInfoModel(
      body: '',
      subject: '',
      recipients: [],
    );
    test('should return failure when failed', () async {
      when(mockRemoteDataSource.sendEmail(tEmailInfoModel)).thenAnswer((realInvocation) => throw SendEmailException(message: Strings.sendEmailFailure));
      final Either<Failure, Success> result = await settingsRepo.sendEmail(tEmailInfoModel);

      verify(mockRemoteDataSource.sendEmail(tEmailInfoModel));
      expect(result, Left(SendEmailFailure(message: Strings.sendEmailFailure)));
    });
    test('should return success when succeeded', () async {
      when(mockRemoteDataSource.sendEmail(tEmailInfoModel)).thenAnswer((realInvocation) => Future.value());
      final Either<Failure, Success> result = await settingsRepo.sendEmail(tEmailInfoModel);

      verify(mockRemoteDataSource.sendEmail(tEmailInfoModel));
      expect(result, Right(SendEmailSuccess(message: Strings.sendEmailSuccess)));
    });
  });
}