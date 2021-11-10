import 'package:equatable/equatable.dart';

class EmailInfo extends Equatable {
  final String body;
  final String subject;
  final List<String> recipients;
  final List<String> attachmentPaths;
  const EmailInfo({
    required this.body,
    required this.subject,
    required this.recipients,
    this.attachmentPaths = const [],
  });

  @override
  List<Object?> get props => [body, subject, recipients, attachmentPaths];
}
