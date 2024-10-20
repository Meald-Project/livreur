import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Delivery for Order #12345 is completed.',
      timestamp: 'Just now',
    ),
    NotificationItem(
      title: 'Your order #67890 is on the way!',
      timestamp: '2 minutes ago',
    ),
    NotificationItem(
      title: 'Order #54321 has been picked up by the delivery person.',
      timestamp: '10 minutes ago',
    ),
    NotificationItem(
      title: 'Your order #09876 is being prepared.',
      timestamp: '15 minutes ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationCard(notification: notification);
          },
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String timestamp;

  NotificationItem({
    required this.title,
    required this.timestamp,
  });
}

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.notifications, color: Colors.orange, size: 30), // Bell icon
            SizedBox(width: 16), // Spacing between icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4), // Spacing
                  Text(
                    notification.timestamp,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
