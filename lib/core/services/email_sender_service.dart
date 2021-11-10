import 'package:flutter_email_sender/flutter_email_sender.dart';

abstract class EmailSenderService {
  Future<void> sendEmail({
    required String body,
    required String subject,
    required List<String> recipients,
    List<String> attachmentPaths = const [],
  });
}

class EmailSenderServiceImpl implements EmailSenderService {
  @override
  Future<void> sendEmail({
    required String body,
    required String subject,
    required List<String> recipients,
    List<String> attachmentPaths = const [],
  }) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: recipients,
      attachmentPaths: attachmentPaths,
    );
    await FlutterEmailSender.send(email);
  }
}
