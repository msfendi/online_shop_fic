import 'package:online_shop_fic/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// AuthLocalDatasource adalah class yang berfungsi untuk menyimpan data autentikasi ke local storage shared preferences

class AuthLocalDatasource {
  // menyimpan data autentikasi setelah login ke local storage (berupa json)
  Future<void> saveAuthData(AuthResponse authResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', authResponse.toJson());
  }

  // mengambil data autentikasi terlogin dari local storage
  Future<AuthResponse?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return AuthResponse.fromJson(authData);
    }
    return null;
  }

// menghapus data autentikasi terlogin dari local storage
  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  // cek apakah terdapat data autentikasi terlogin di local storage
  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('auth_data');
    if (authData != null) {
      return true;
    } else {
      return false;
    }
  }
}
