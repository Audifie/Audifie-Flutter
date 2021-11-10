import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/email_sender_service.dart';
import 'package:audifie_version_1/features/settings/data/models/email_info_model.dart';

abstract class SettingsRemoteDataSource {
  Future<void> sendEmail(EmailInfoModel emailInfoModel);
}

class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final EmailSenderService emailSenderService = sl<EmailSenderService>();

  @override
  Future<void> sendEmail(EmailInfoModel emailInfoModel) async {
    try {
      await emailSenderService.sendEmail(
        body: emailInfoModel.body,
        subject: emailInfoModel.subject,
        recipients: emailInfoModel.recipients,
        attachmentPaths: emailInfoModel.attachmentPaths,
      );
    } catch (e) {
      throw SendEmailException(message: e.toString());
    }
  }
}
