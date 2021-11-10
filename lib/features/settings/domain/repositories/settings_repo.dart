import 'dart:io';

import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/features/settings/domain/entities/email_info.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepo {
  Future<Either<Failure, List<File>>> pickFiles();
  Future<Either<Failure, Success>> sendEmail(EmailInfo emailInfo);
}