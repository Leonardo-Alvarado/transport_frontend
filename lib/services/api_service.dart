import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://api.miempresa.com"; // Reemplaza con tu URL de backend

  // Método para login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Devuelve el token o los datos del usuario
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }

  // Método para registrar un nuevo usuario
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body); // Datos del nuevo usuario
    } else {
      throw Exception('Error al registrar usuario');
    }
  }

  // Método para hacer una reserva
  Future<Map<String, dynamic>> makeReservation(String userId, String driverId, String destination) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reservations'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userId': userId,
        'driverId': driverId,
        'destination': destination,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Reserva realizada con éxito
    } else {
      throw Exception('Error al hacer la reserva');
    }
  }

  // Obtener la lista de conductores disponibles
  Future<List<Map<String, dynamic>>> getDrivers() async {
    final response = await http.get(Uri.parse('$baseUrl/drivers'));

    if (response.statusCode == 200) {
      List<dynamic> drivers = json.decode(response.body);
      return List<Map<String, dynamic>>.from(drivers);
    } else {
      throw Exception('Error al obtener conductores');
    }
  }
}
