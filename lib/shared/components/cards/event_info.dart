import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventInfo extends StatelessWidget {
  final String description;
  final String eventDate;
  final String eventLink;

  const EventInfo({
    super.key,
    required this.description,
    required this.eventDate,
    required this.eventLink,
  });

  String _formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Endereço:',
                style:
                    const TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Data:',
                style:
                    const TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              Text(
                _formatDate(eventDate),
                style: const TextStyle(fontSize: 16.0, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Acesso:',
                style:
                    const TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              GestureDetector(
                onTap: () => _launchURL(eventLink),
                child: Text(
                  eventLink,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
