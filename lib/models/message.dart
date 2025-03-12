class Message {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String timestamp;
  final String category; // "Chats", "Orders", "Activities", "Promos"
  final String? tag; // Optional tag like "HONOR"
  bool isRead;

  Message({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.timestamp,
    required this.category,
    this.tag,
    this.isRead = false,
  });
}
