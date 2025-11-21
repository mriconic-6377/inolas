class ChatRoom {
  final String id;
  final String name;
  final String description;
  final bool isOfficial;
  final int memberCount;
  final DateTime lastActivity;
  final String lastMessage;
  final bool hasUnread;

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.isOfficial,
    required this.memberCount,
    required this.lastActivity,
    required this.lastMessage,
    this.hasUnread = false,
  });

  String get timeAgo {
    final difference = DateTime.now().difference(lastActivity);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inMinutes}m';
    }
  }
}

class ChatMessage {
  final String id;
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isMe;
  final bool isAdmin;

  ChatMessage({
    required this.id,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isMe,
    this.isAdmin = false,
  });
}
