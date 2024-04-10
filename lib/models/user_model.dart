import 'package:posta/utils/typedefs.dart';

class UserModel{
  final String username;
  UserId? userId;
  final String email;
  final String? photoLink;

  UserModel({required this.username, required this.userId, required this.email, this.photoLink}):super();


  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'userId': userId,
      'email': email,
      'photoLink': photoLink,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      userId: map['userId'] as UserId,
      email: map['email'] as String,
      photoLink: map['photoLink'] as String,
    );
  }
}