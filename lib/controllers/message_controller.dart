import 'package:get/get.dart';
import 'package:gurkha_pasal/models/message.dart';

class MessageController extends GetxController {
  var messages = <Message>[].obs;
  var selectedTab = "Promos".obs; // Default tab

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() {
    messages.assignAll([
      Message(
        id: "1",
        title: "Your Misha Deal is waiting",
        description: "Glow like a pro with deals up to 10% OFF + Free Delivery",
        imageUrl: "https://example.com/misha_deal.jpg",
        timestamp: "Last 7 days",
        category: "Promos",
      ),
      Message(
        id: "2",
        title: "20% OFF on Your",
        description:
            "Head to the Gems Channel, shop your faves, and let the discounts roll",
        imageUrl: "https://example.com/gems_channel.jpg",
        timestamp: "Last 7 days",
        category: "Promos",
      ),
      Message(
        id: "3",
        title: "HONOR X9b",
        description: "The Toughest Smartphone in Nepal. Just Rs. 48,999",
        imageUrl: "https://example.com/honor_x9b.jpg",
        timestamp: "Yesterday",
        category: "Promos",
        tag: "HONOR",
      ),
      // Add more messages for other tabs if needed
    ]);
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }

  List<Message> getMessagesForTab() {
    return messages
        .where((message) => message.category == selectedTab.value)
        .toList();
  }

  void markAllAsRead() {
    for (var message in messages) {
      message.isRead = true;
    }
    messages.refresh();
  }
}
