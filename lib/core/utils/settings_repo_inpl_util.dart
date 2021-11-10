import 'package:audifie_version_1/features/settings/data/models/email_info_model.dart';
import 'package:audifie_version_1/features/settings/domain/entities/email_info.dart';

class SettingsRepoImplUtil {
  static emailInfoToModel(EmailInfo emailInfo) {
    return EmailInfoModel(
        body: emailInfo.body,
        subject: emailInfo.subject,
        recipients: emailInfo.recipients,
        attachmentPaths: emailInfo.attachmentPaths);
  }
}
