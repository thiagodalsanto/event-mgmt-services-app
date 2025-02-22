import 'package:event_mgmt_services_app/shared/components/cards/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:event_mgmt_services_app/features/restaurant/models/restaurant.dart';

class RestaurantListView extends StatelessWidget {
  final List<Restaurant?>? restaurants;

  const RestaurantListView({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    if (restaurants!.isEmpty) {
      return const Center(
        child: Text("Nenhum restaurante encontrado", style: TextStyle(color: Colors.white)),
      );
    }

    return SizedBox(
      height: 180,
      child: Stack(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: restaurants!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: index == restaurants!.length - 1 ? 16 : 8),
                child: RestaurantCard(
                  name: restaurants![index]!.name,
                  type: restaurants![index]!.categories.join(', '),
                  address: restaurants![index]!.location.address,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
