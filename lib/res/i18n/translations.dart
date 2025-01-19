import 'dart:io';

import 'package:calendar_mgmt_services_app/res/i18n/strings/en_us.dart';
import 'package:calendar_mgmt_services_app/res/i18n/strings/pt_br.dart';
import 'package:calendar_mgmt_services_app/res/i18n/strings/strings_declaration.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Translations {
  static Map<String, ITranslations> stringToLocale = {
    "pt_BR": PtBr(),
    "en_US": EnUs(),
    "unknown": EnUs(),
  };
  static String platformLocale = kIsWeb
      ? 'pt_BR'
      : stringToLocale.containsKey(Platform.localeName)
          ? Platform.localeName
          : 'pt_Br';
  static ITranslations string = stringToLocale[platformLocale]!;

  static void load(Locale locale) {
    switch (locale.toString()) {
      case 'en_US':
        string = EnUs();
        break;
      default:
        string = PtBr();
        break;
    }
  }
}
