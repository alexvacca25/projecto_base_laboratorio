import 'dart:html';

class LocalStorageUtil {
  // Método para escribir en el localStorage
  static void write(String key, String value) {
    window.localStorage[key] = value;
  }

  // Método para leer desde el localStorage
  static String? read(String key) {
    return window.localStorage[key];
  }

  // Método para eliminar un item del localStorage
  static void remove(String key) {
    window.localStorage.remove(key);
  }
}
