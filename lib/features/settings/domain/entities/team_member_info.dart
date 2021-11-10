import 'package:equatable/equatable.dart';

class TeamMemberInfo extends Equatable {
  final String? imageURL;
  final String name;
  final String title;
  final String? email;
  final String? linkedIn;
  final String? twitter;

  const TeamMemberInfo({
    this.imageURL,
    required this.name,
    required this.title,
    this.email,
    this.linkedIn,
    this.twitter,
  });

  @override
  List<Object?> get props => [imageURL, name, title, email, linkedIn, twitter];
}