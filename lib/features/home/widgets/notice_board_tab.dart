import 'package:flutter/material.dart';
import '../models/notice_model.dart';
import '../../../core/theme/theme.dart';
import '../screens/notice_detail_screen.dart';

class NoticeBoardTab extends StatelessWidget {
  const NoticeBoardTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final notices = [
      Notice(
        id: '1',
        title: 'Mid-Term Examination Schedule',
        description: 'The mid-term exams will be held from Nov 20-25. Please check the detailed schedule attached below for your respective batches.',
        author: 'Dr. Anjali Mehta',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        category: 'Important',
        isImportant: true,
      ),
      Notice(
        id: '2',
        title: 'Tech Fest 2025 - Call for Volunteers',
        description: 'Join us in organizing the biggest tech fest! Registration open till Nov 15. We need volunteers for various committees including logistics, hospitality, and technical support.',
        author: 'Student Council',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        category: 'Events',
      ),
      Notice(
        id: '3',
        title: 'Library Closed - Gandhi Jayanti',
        description: 'The central library will remain closed on October 2nd for Gandhi Jayanti. Regular hours will resume from October 3rd.',
        author: 'Library Committee',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        category: 'Clubs',
      ),
      Notice(
        id: '4',
        title: 'Workshop: Machine Learning Basics',
        description: 'Free workshop on ML fundamentals. Limited seats available. Register now! The workshop will cover basic concepts of supervised and unsupervised learning.',
        author: 'CS Department',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        category: 'Events',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notices.length,
      itemBuilder: (context, index) {
        final notice = notices[index];
        return _NoticeCard(notice: notice);
      },
    );
  }
}

class _NoticeCard extends StatelessWidget {
  final Notice notice;

  const _NoticeCard({required this.notice});

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Important':
        return const Color(0xFFFFEBEE);
      case 'Events':
        return const Color(0xFFF3E5F5);
      case 'Clubs':
        return const Color(0xFFE3F2FD);
      case 'Class':
        return const Color(0xFFE8F5E9);
      default:
        return const Color(0xFFF5F5F5);
    }
  }

  Color _getCategoryTextColor(String category) {
    switch (category) {
      case 'Important':
        return const Color(0xFFD32F2F);
      case 'Events':
        return const Color(0xFF7B1FA2);
      case 'Clubs':
        return const Color(0xFF1976D2);
      case 'Class':
        return const Color(0xFF388E3C);
      default:
        return const Color(0xFF616161);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoticeDetailScreen(notice: notice),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    notice.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(notice.category),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    notice.category,
                    style: TextStyle(
                      color: _getCategoryTextColor(notice.category),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              notice.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'By ${notice.author}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  notice.timeAgo,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
