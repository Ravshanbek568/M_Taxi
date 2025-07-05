import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? email;
  String? password;
  String? avatarUrl;
  String? cardNumber;
  String? cardExpiry;

  static Future<UserModel> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel()
      ..firstName = prefs.getString('firstName')
      ..lastName = prefs.getString('lastName')
      ..phone = prefs.getString('phone')
      ..address = prefs.getString('address')
      ..email = prefs.getString('email')
      ..password = prefs.getString('password')
      ..cardNumber = prefs.getString('cardNumber')
      ..cardExpiry = prefs.getString('cardExpiry');
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstName ?? '');
    await prefs.setString('lastName', lastName ?? '');
    await prefs.setString('phone', phone ?? '');
    await prefs.setString('address', address ?? '');
    await prefs.setString('email', email ?? '');
    if (password != null) await prefs.setString('password', password!);
    if (cardNumber != null) await prefs.setString('cardNumber', cardNumber!);
    if (cardExpiry != null) await prefs.setString('cardExpiry', cardExpiry!);
  }
}