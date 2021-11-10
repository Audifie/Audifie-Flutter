import 'package:audifie_version_1/core/constants/palette.dart';
import 'package:audifie_version_1/core/constants/strings.dart';
import 'package:audifie_version_1/core/service_locator.dart';
import 'package:audifie_version_1/core/size_config.dart';
import 'package:audifie_version_1/core/widgets/core_widgets.dart';
import 'package:audifie_version_1/features/settings/presenter/notifiers/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class SupportPage extends StatefulWidget {
  static const String routeName = '/support_page';

  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  static const double _horizontalPadding = 34;

  static const String _howHelp = "How can we help you?";
  static const String _subject = "Subject";
  static const String _yourMessage = "Your Message";
  static const String _addFiles = "Add Files";
  static const String _send = "SEND";

  static SizeConfig sc = sl<SizeConfig>();

  static OutlineInputBorder _border(Color color, SizeConfig sc) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(sc.height(15)),
      borderSide: BorderSide(color: color, width: sc.height(2)),
    );
  }

  TextEditingController _subjectController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  bool _isSubjectEmpty = false;
  bool _isBodyEmpty = false;

  Widget fileChip(BuildContext context, String path, int index) {
    return Padding(
      padding: EdgeInsets.only(left: sc.width(12)),
      child: Chip(
        useDeleteButtonTooltip: true,
        onDeleted: () {
          context.read<SettingsNotifier>().removeFile(index);
        },
        deleteIcon: Icon(Icons.clear,
            size: sc.height(18), color: Palette.secondaryText),
        backgroundColor: Palette.audioDocCardBg,
        padding: EdgeInsets.symmetric(
            vertical: sc.height(4), horizontal: sc.width(6)),
        label: Text(
          basename(path),
          style: TStyle(
            color: Palette.secondaryText,
            size: sc.text(14),
          ),
        ),
        elevation: 0,
        clipBehavior: Clip.none,
      ),
    );
  }

  void _resetFields(BuildContext context) {
    _bodyController.clear();
    _subjectController.clear();
    context.read<SettingsNotifier>().resetFiles();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bg,
      appBar: IndependentAppBar(context: context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(sc.width(_horizontalPadding)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sc.height(41)),
              Text(
                _howHelp,
                style: TStyle(
                  color: Palette.primaryText,
                  size: sc.text(20),
                ).copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: sc.height(64)),
              // Subject Text form field
              CustomTextFields(
                errorText: _isSubjectEmpty ? Strings.fieldCantEmpty : null,
                controller: _subjectController,
                labelText: _subject,
                onChange: (subject) {},
              ),
              SizedBox(height: sc.height(26)),
              // Body Text form field
              TextFormField(
                controller: _bodyController,
                style: TStyle(color: Palette.primaryText, size: sc.text(16)),
                onChanged: (body) {},
                cursorColor: Palette.primary,
                maxLines: 6,
                decoration: InputDecoration(
                  errorText: _isBodyEmpty ? Strings.fieldCantEmpty : null,
                  errorStyle: TStyle(color: Palette.error, size: sc.text(14)),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: sc.height(16), horizontal: sc.width(40)),
                  hintText: _yourMessage,
                  hintStyle:
                      TStyle(color: Palette.textFieldLabel, size: sc.text(16)),
                  border: _border(Palette.textFieldBorder, sc),
                  errorBorder: _border(Palette.error, sc),
                  enabledBorder: _border(Palette.textFieldBorder, sc),
                  disabledBorder: _border(Palette.textFieldBorder, sc),
                  focusedBorder: _border(Palette.textFieldFocusedBorder, sc),
                  focusedErrorBorder: _border(Palette.error, sc),
                ),
              ),
              SizedBox(height: sc.height(41)),
              // Add file Button
              Consumer<SettingsNotifier>(
                builder: (_, notifier, __) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: sc.height(52),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Palette.textFieldBorder,
                              width: sc.height(1),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(sc.height(8)),
                              bottomLeft: Radius.circular(sc.height(8)),
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: sc.height(2)),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              itemCount: notifier.files.length,
                              itemBuilder: (_, index) {
                                final String path = notifier.files[index].path;
                                return fileChip(context, path, index);
                              },
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          // TODO: Attach files
                          // attachmentPaths =
                          //     await context.read<SettingsNotifier>().addFiles();
                          context.read<SettingsNotifier>().pickFiles(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Palette.primaryText,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(sc.height(8)),
                              bottomRight: Radius.circular(sc.height(8)),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: sc.width(18),
                              vertical: sc.height(17)),
                        ),
                        child: Text(
                          _addFiles,
                          style: TStyle(color: Colors.black, size: sc.text(14)),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: sc.height(30)),
              // Send Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    _isSubjectEmpty = true;
                    _isBodyEmpty = true;
                    if (_subjectController.text.isNotEmpty) {
                      _isSubjectEmpty = false;
                    }
                    if (_bodyController.text.isNotEmpty) {
                      _isBodyEmpty = false;
                    }

                    if (!_isSubjectEmpty && !_isBodyEmpty) {
                      final String subject = _subjectController.text;
                      final String body = _bodyController.text;

                      final bool isEmailSent = await context.read<SettingsNotifier>().sendEmail(
                            context,
                            subject: subject,
                            body: body,
                          );
                      if (isEmailSent)
                        _resetFields(context);
                    }

                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Palette.primaryText,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sc.height(100))),
                    padding: EdgeInsets.symmetric(
                        horizontal: sc.width(32), vertical: sc.height(15)),
                  ),
                  child: Text(
                    _send,
                    style: TStyle(
                      color: Colors.black,
                      size: sc.text(14),
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
