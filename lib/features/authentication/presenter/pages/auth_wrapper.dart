import 'package:audifie_version_1/features/authentication/presenter/pages/sign_in_page.dart';
import 'package:audifie_version_1/features/authentication/presenter/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  PageController _pageController = PageController();
  bool _isSignInPage = true;

  void toggleView() {
    setState(() {
      _isSignInPage = !_isSignInPage;
      _pageController.animateToPage(
        _isSignInPage ? 0 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return OtpPage();
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        SignInPage(toggleView: toggleView),
        SignUpPage(toggleView: toggleView),
      ],
    );
  }
}
