import 'dart:io';

import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';

class FilePickerUsecase {
  final SettingsRepo settingsRepo = sl<SettingsRepo>();

  Future<Either<Failure, List<File>>> pickFiles() {
    return settingsRepo.pickFiles();
  }
}