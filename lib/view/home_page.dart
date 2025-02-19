import 'package:calendar_mgmt_services_app/providers/user_provider.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/current_location.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/event_card.dart';
import 'package:calendar_mgmt_services_app/shared/components/cards/main_event_card.dart';
import 'package:calendar_mgmt_services_app/shared/components/header/header.dart';
import 'package:calendar_mgmt_services_app/shared/components/textfields/location_search_bar.dart';
import 'package:calendar_mgmt_services_app/shared/components/texts/section_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.unfocus();
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    final List<Map<String, String>> eventosRecomendados = [
      {
        'titulo': 'Evento 1',
        'descricao': 'Descubra experiências únicas e incríveis neste evento especial.',
        'imagem':
            'https://static.vecteezy.com/system/resources/thumbnails/049/462/195/small/inspiring-woman-leading-a-technology-seminar-with-enthusiasm-and-confidence-in-front-of-a-large-audience-photo.jpeg',
      },
      {
        'titulo': 'Evento 2',
        'descricao': 'Um encontro inesquecível para amantes da música e cultura.',
        'imagem':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEzBgvtI2s4JmDlX9HMxum6cs7LJAwb4iA0w&s',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  title: "Bem-vindo, ${user!.name}!",
                  onSettingsPressed: () {
                    Navigator.pushNamed(context, '/personal-data');
                  },
                ),
                const SizedBox(height: 20),
                LocationSearchBar(
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                ),
                const SizedBox(height: 10),
                CurrentLocation(location: user.localization),
                const SizedBox(height: 20),
                MainEventCard(
                  titulo: 'Título do Evento Principal',
                  imagem:
                      'https://static.vecteezy.com/ti/fotos-gratis/t2/52948518-vermelho-tapete-evento-com-convidados-esperando-atras-veludo-cordas-dentro-uma-escuro-local-foto.jpeg',
                  onTap: () {
                    Navigator.pushNamed(context, '/event-details', arguments: {
                      'titulo': 'Título do Evento Principal',
                      'descricao': 'Uma experiência única espera por você neste evento especial!',
                      'imagem':
                          'https://static.vecteezy.com/ti/fotos-gratis/t2/52948518-vermelho-tapete-evento-com-convidados-esperando-atras-veludo-cordas-dentro-uma-escuro-local-foto.jpeg',
                    });
                  },
                ),
                const SizedBox(height: 20),
                const SectionTitle(title: "Eventos Recomendados"),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: eventosRecomendados.length,
                    itemBuilder: (context, index) {
                      final evento = eventosRecomendados[index];
                      return EventCard(
                        titulo: evento['titulo']!,
                        descricao: evento['descricao']!,
                        imagem: evento['imagem']!,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/event-details',
                            arguments: {
                              'titulo': evento['titulo']!,
                              'descricao': evento['descricao']!,
                              'imagem': evento['imagem']!,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
