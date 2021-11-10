import 'package:audifie_version_1/core/errors/exception.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/services/email_sender_service.dart';
import 'package:audifie_version_1/features/settings/data/data_sources/settings_remote_data_source.dart';
import 'package:audifie_version_1/features/settings/data/models/email_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/service_locator_test.dart';

@GenerateMocks([EmailSenderService])
void main() {
  setUpServicesForTest();

  final EmailSenderService mockEmailSenderService = sl<EmailSenderService>();
  final SettingsRemoteDataSource remoteDataSource = SettingsRemoteDataSourceImpl();
  group('send email', () {
    final EmailInfoModel tEmailInfoModel = EmailInfoModel(
      body: '',
      subject: '',
      recipients: [],
    );
    test('should throw send email exception when failed', () async {
      when(mockEmailSenderService.sendEmail(
        body: tEmailInfoModel.body,
        subject: tEmailInfoModel.subject,
        recipients: tEmailInfoModel.recipients,
        attachmentPaths: tEmailInfoModel.attachmentPaths,
      )).thenAnswer((realInvocation) => throw Exception('error'));

      expect(() => remoteDataSource.sendEmail(tEmailInfoModel),
          throwsA(isA<SendEmailException>()));
    });
  });
}
