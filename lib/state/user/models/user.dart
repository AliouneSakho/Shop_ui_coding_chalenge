import 'package:plants_ui/state/auth/typedefs/user_id.dart';
import 'package:plants_ui/state/user/constants/user_field_names.dart';

class User {
  final UserId id;
  final String userName;
  final String? profileUrl;
  final List<String> favorites;
  final List<String> cart;

  const User({
    required this.id,
    required this.userName,
    required this.profileUrl,
    required this.favorites,
    required this.cart,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[UserFieldNames.userId],
      userName: json[UserFieldNames.userName],
      profileUrl: json[UserFieldNames.profileUrl],
      favorites: List.from(json[UserFieldNames.favorites]),
      cart: List.from(json[UserFieldNames.cart]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserFieldNames.userId: id,
      UserFieldNames.userName: userName,
      UserFieldNames.profileUrl: profileUrl,
      UserFieldNames.favorites: favorites,
      UserFieldNames.cart: cart,
    };
  }
}
