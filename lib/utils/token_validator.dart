import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart' as html;

class TokenValidator {
  static bool isTokenValid = false;

  static Future<void> validateToken() async {
    try {
      final token = html.window.localStorage['token'];
      if (token == null) {
        throw Exception('Token no encontrado');
      }

      final response = await http.get(
        Uri.parse('https://thumano.unad.edu.co/apptesteo-sighum-backend/api/auth/renew'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['ok'] == true) {
          isTokenValid = true;
          html.window.localStorage['token'] = data['token']; // Actualizar token en localStorage
        } else {
          isTokenValid = false;
          throw Exception('Token no válido');
        }
      } else {
        isTokenValid = false;
        throw Exception('Error en la respuesta del servidor');
      }
    } catch (e) {
      isTokenValid = false;
      print('Error al validar el token: $e');
      throw e;
    }
  }
}
