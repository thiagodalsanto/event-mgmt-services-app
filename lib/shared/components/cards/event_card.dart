import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String imagem;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.imagem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imagem,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          descricao,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
