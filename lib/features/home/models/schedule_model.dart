import 'package:flutter/material.dart';

class ScheduleItem {
  final String id;
  final String subject;
  final String room;
  final String faculty;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String type; // 'Lecture', 'Lab'

  ScheduleItem({
    required this.id,
    required this.subject,
    required this.room,
    required this.faculty,
    required this.startTime,
    required this.endTime,
    required this.type,
  });

  String get timeString {
    final start = '${startTime.hour}:${startTime.minute.toString().padLeft(2, '0')}';
    final end = '${endTime.hour}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$start - $end';
  }
}
