import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DriversScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conductores disponibles')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _apiService.getDrivers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar conductores'));
          }

          final drivers = snapshot.data ?? [];
          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(drivers[index]['name']),
                subtitle: Text('ID: ${drivers[index]['id']}'),
              );
            },
          );
        },
      ),
    );
  }
}
