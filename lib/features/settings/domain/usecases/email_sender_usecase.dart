import 'package:audifie_version_1/core/errors/failure.dart';
import 'package:audifie_version_1/core/errors/success.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/features/settings/domain/entities/email_info.dart';
import 'package:audifie_version_1/features/settings/domain/repositories/settings_repo.dart';
import 'package:dartz/dartz.dart';

class EmailSenderUsecase {
  final SettingsRepo settingsRepo = sl<SettingsRepo>();

  Future<Either<Failure, Success>> sendEmail(EmailInfo emailInfo) {
    return settingsRepo.sendEmail(emailInfo);
  }
}