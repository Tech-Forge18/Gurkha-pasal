import 'package:get/get.dart';

class Message {
  final String title;
  final String subtitle;
  final String timestamp;
  final String type;
  final bool isRead;

  Message({
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.type,
    required this.isRead,
  });
}

class MessageController extends GetxController {
  var selectedTab = "Chats".obs;
  var messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Sample messages (replace with actual data source)
    messages.assignAll([
      Message(
        title: "Support Team",
        subtitle: "Your order has been shipped!",
        timestamp: "Today",
        type: "Orders",
        isRead: false,
      ),
      Message(
        title: "John Doe",
        subtitle: "Hey, how are you?",
        timestamp: "Today",
        type: "Chats",
        isRead: true,
      ),
      Message(
        title: "Promo Alert",
        subtitle: "50% off on your next purchase!",
        timestamp: "Yesterday",
        type: "Promos",
        isRead: false,
      ),
      Message(
        title: "Activity",
        subtitle: "You reviewed a product.",
        timestamp: "Yesterday",
        type: "Activities",
        isRead: true,
      ),
    ]);
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  List<Message> getMessagesForTab() {
    return messages
        .where((message) => message.type == selectedTab.value)
        .toList();
  }

  void markAllAsRead() {
    for (var message in messages) {
      message = Message(
        title: message.title,
        subtitle: message.subtitle,
        timestamp: message.timestamp,
        type: message.type,
        isRead: true,
      );
    }
    messages.refresh();
  }
}
