import 'package:calendar_mgmt_services_app/view/event_details_page.dart';
import 'package:calendar_mgmt_services_app/view/home_page.dart';
import 'package:calendar_mgmt_services_app/view/login_page.dart';
import 'package:calendar_mgmt_services_app/view/personal_data_page.dart';
import 'package:calendar_mgmt_services_app/view/register_page.dart';
import 'package:flutter/material.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteNames.eventDetails:
        return MaterialPageRoute(builder: (_) => EventDetailsPage());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case RouteNames.personalData:
        return MaterialPageRoute(builder: (_) => PersonalDataPage());

      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
