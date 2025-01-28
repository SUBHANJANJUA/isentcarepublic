import 'package:get/get.dart';

class NotificationController extends GetxController {
  // Static list of notifications
  final notifications = [
    {
      'photoUrl':
          'https://via.placeholder.com/150', // Replace with actual image URL
      'text': 'Your shift has been approved.',
      'time': '5 min ago',
    },
    {
      'photoUrl': 'https://via.placeholder.com/150',
      'text': 'Reminder: Your shift starts tomorrow at 9:00 AM.',
      'time': '1 hr ago',
    },
    {
      'photoUrl': 'https://via.placeholder.com/150',
      'text': 'Payment for last shift has been processed.',
      'time': '1 day ago',
    },
    {
      'photoUrl': 'https://via.placeholder.com/150',
      'text': 'Your profile has been updated successfully.',
      'time': '2 days ago',
    },
    {
      'photoUrl': 'https://via.placeholder.com/150',
      'text': 'New shift available in your area.',
      'time': '3 days ago',
    },
  ];
}
