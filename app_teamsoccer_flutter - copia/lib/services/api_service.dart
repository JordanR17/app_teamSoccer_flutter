import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://localhost:3000';

  // Método para obtener los equipos
  Future<List<dynamic>> fetchTeams() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/teams'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener los equipos');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Método para obtener los jugadores
  Future<List<dynamic>> fetchPlayers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/players'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener los jugadores');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Método para obtener los torneos
  Future<List<dynamic>> fetchTournaments() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/tournaments'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener los torneos');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
