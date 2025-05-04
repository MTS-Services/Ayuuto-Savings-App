import 'package:get/get.dart';

class Language extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'app_name': 'Ayuuto Savings App',
      'home': 'Home',
      'groups': 'Groups',
      'all_users': 'All Users',
      'payments': 'Payments',
      'my_groups': 'My Groups',
      'available_groups': 'Available Groups',
      'settings': 'Settings',
      // Add more translations here
    },
    'so_SO': {
      'app_name': 'Ayuuto Savings App',
      'home': 'Guriga',
      'groups': 'Kooxaha',
      'all_users': 'Dhammaan Isticmaaleyaasha',
      'payments': 'Lacag bixinta',
      'my_groups': 'Kooxdayda',
      'available_groups': 'Kooxaha La Heli Karo',
      // Add more translations here
    },
  };
}