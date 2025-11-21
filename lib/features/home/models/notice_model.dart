class Notice {
  final String id;
  final String title;
  final String description;
  final String author;
  final DateTime timestamp;
  final String category; // 'Important', 'Events', 'Class', 'Other'
  final bool isImportant;
  final String? attachmentUrl;

  Notice({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.timestamp,
    required this.category,
    this.isImportant = false,
    this.attachmentUrl,
  });

  String get timeAgo {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
