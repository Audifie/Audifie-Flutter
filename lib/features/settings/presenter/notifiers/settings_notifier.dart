import 'dart:io';

import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/settings/domain/entities/email_info.dart';
import 'package:audifie_version_1/features/settings/domain/usecases/email_sender_usecase.dart';
import 'package:audifie_version_1/features/settings/domain/usecases/file_picker_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsNotifier extends ChangeNotifier {
  final FilePickerUsecase filePickerUsecase = FilePickerUsecase();
  final EmailSenderUsecase emailSenderUsecase = EmailSenderUsecase();

  List<File> _files = [];
  List<File> get files => _files;

  void pickFiles(BuildContext context) async {
    await filePickerUsecase.pickFiles()
      ..fold((l) {
        ScaffoldMessenger.of(context).showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _files.addAll(r);
      });
    
    notifyListeners();
  }

  void removeFile(int index) {
    _files.removeAt(index);
    notifyListeners();
  }

  Future<bool> sendEmail(BuildContext context, {required String body, required String subject}) async {
    bool isEmailSent = false;
    
    final EmailInfo emailInfo = EmailInfo(
      body: body, 
      subject: subject,
      recipients: ['dhritiman.roy.dev@gmail.com'],
      attachmentPaths: _files.map((e) => e.path).toList(),
    );

    await emailSenderUsecase.sendEmail(emailInfo)..fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(Snackbar(message: l.message));
    }, (r) {
      ScaffoldMessenger.of(context).showSnackBar(Snackbar(message: r.message));
      isEmailSent = true;
    });

    return isEmailSent;
  }

  void resetFiles() {
    _files = [];
    notifyListeners();
  }
}
