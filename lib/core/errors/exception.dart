class PickFilesException implements Exception {
  final String message;
  const PickFilesException({required this.message});
}

class GetException implements Exception {
  final String message;
  const GetException({required this.message});
}

class SendEmailException implements Exception {
  final String message;
  const SendEmailException({required this.message});
}

class SignUpException implements Exception {
  final String message;
  const SignUpException({required this.message});
}

class SignInException implements Exception {
  final String message;
  const SignInException({required this.message});
}

class SignOutException implements Exception {
  final String message;
  const SignOutException({required this.message});
}

class ReadException implements Exception {
  final String message;
  const ReadException({required this.message});
}

class WriteException implements Exception {
  final String message;
  const WriteException({required this.message});
}