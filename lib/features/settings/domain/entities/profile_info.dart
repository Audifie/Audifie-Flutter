import 'package:equatable/equatable.dart';

class ProfileInfo extends Equatable {
  final String email;
  final String? name;
  final String? imageUrl;

  const ProfileInfo({
    required this.email,
    this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [email, name, imageUrl];
}
