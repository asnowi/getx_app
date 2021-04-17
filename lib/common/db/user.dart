import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User extends HiveObject{
  String userId;
  String phone;
  String token;
  String avatarImg;

  User({
    this.userId,
    this.phone,
    this.token,
    this.avatarImg,
  });

  @override
  String toString() {
    return 'User{userId: $userId, phone: $phone, token: $token, avatarImg: $avatarImg}';
  }
}