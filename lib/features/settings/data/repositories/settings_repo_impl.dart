import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/utils/settings_repo_inpl_util.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:audifie_version_1/features/settings/domain/entities/email_info.dart';
import 'dart:io';

import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';

class SettingsRepoImpl implements SettingsRepo {
  final SettingsLocalDataSource settingsLocalDataSource = sl<SettingsLocalDataSource>();
  final SettingsRemoteDataSource settingsRemoteDataSource = sl<SettingsRemoteDataSource>();

  @override
  Future<Either<Failure, List<File>>> pickFiles() async {
    try {
      return Right(await settingsLocalDataSource.pickFiles());
    } on PickFilesException catch (e) {
      print('Exception: ' + e.message + '-----------------');
      return Left(PickFilesFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Success>> sendEmail(EmailInfo emailInfo) async {
    try {
      await settingsRemoteDataSource.sendEmail(SettingsRepoImplUtil.emailInfoToModel(emailInfo));
      return Right(SendEmailSuccess(message: Strings.sendEmailSuccess));
    } on SendEmailException catch (e) {
      return Left(SendEmailFailure(message: e.message));
    }
  }
}