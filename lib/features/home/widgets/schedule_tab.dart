import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
import '../../../core/theme/theme.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final scheduleItems = [
      ScheduleItem(
        id: '1',
        subject: 'Data Structures',
        room: 'Lab 301',
        faculty: 'Dr. Priya Sharma',
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 10, minute: 0),
        type: 'Lab',
      ),
      ScheduleItem(
        id: '2',
        subject: 'Operating Systems',
        room: 'Room 205',
        faculty: 'Prof. Rajesh Kumar',
        startTime: const TimeOfDay(hour: 10, minute: 15),
        endTime: const TimeOfDay(hour: 11, minute: 15),
        type: 'Lecture',
      ),
      ScheduleItem(
        id: '3',
        subject: 'Database Management',
        room: 'Room 310',
        faculty: 'Dr. Anjali Mehta',
        startTime: const TimeOfDay(hour: 11, minute: 30),
        endTime: const TimeOfDay(hour: 12, minute: 30),
        type: 'Lecture',
      ),
      ScheduleItem(
        id: '4',
        subject: 'Computer Networks',
        room: 'Room 402',
        faculty: 'Prof. Amit Gupta',
        startTime: const TimeOfDay(hour: 14, minute: 0),
        endTime: const TimeOfDay(hour: 15, minute: 0),
        type: 'Lecture',
      ),
    ];

    return Column(
      children: [
        // Day Selector
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _DayChip(day: 'Monday', isSelected: true),
              _DayChip(day: 'Tuesday', isSelected: false),
              _DayChip(day: 'Wednesday', isSelected: false),
              _DayChip(day: 'Thursday', isSelected: false),
              _DayChip(day: 'Friday', isSelected: false),
            ],
          ),
        ),
        
        // Schedule List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: scheduleItems.length,
            itemBuilder: (context, index) {
              return _ScheduleCard(item: scheduleItems[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  final String day;
  final bool isSelected;

  const _DayChip({required this.day, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(day),
        selected: isSelected,
        onSelected: (bool selected) {},
        backgroundColor: const Color(0xFFF3F4F6),
        selectedColor: AppTheme.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppTheme.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
        showCheckmark: false,
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final ScheduleItem item;

  const _ScheduleCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        children: [
          // Time Column
          Container(
            width: 80,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time, color: AppTheme.primaryColor, size: 20),
                const SizedBox(height: 4),
                Text(
                  item.timeString.split(' - ')[0],
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                 Text(
                  '-',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  item.timeString.split(' - ')[1],
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.subject,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: item.type == 'Lab' ? Colors.purple.shade100 : Colors.blue.shade100,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.type,
                        style: TextStyle(
                          fontSize: 10,
                          color: item.type == 'Lab' ? Colors.purple : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      item.room,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 16, color: AppTheme.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      item.faculty,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
