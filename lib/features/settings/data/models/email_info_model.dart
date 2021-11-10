import 'package:audifie_version_1/features/settings/domain/entities/email_info.dart';

class EmailInfoModel extends EmailInfo {
  EmailInfoModel({
    required String body,
    required String subject,
    required List<String> recipients,
    List<String> attachmentPaths = const [],
  }) : super(
          body: body,
          subject: subject,
          recipients: recipients,
          attachmentPaths: attachmentPaths,
        );
}
