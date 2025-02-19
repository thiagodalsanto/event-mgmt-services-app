import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String name;
  final String type;
  final String address;

  const RestaurantCard({
    super.key,
    required this.name,
    required this.type,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.restaurant, color: Colors.redAccent, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Restaurante Recomendado',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Nome: $name', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('Tipo: $type', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text('Endereço: $address', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
