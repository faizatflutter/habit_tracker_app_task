import 'package:flutter/material.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_colors.dart';
import 'package:habit_tracker_app_task/src/core/extensions/string_extensions.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/domain/entity/habit.dart';

class HabitListTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onComplete;
  final bool isCompletedToday;

  const HabitListTile({
    super.key,
    required this.habit,
    required this.onComplete,
    required this.isCompletedToday,
  });

  @override
  Widget build(BuildContext context) {
    final streak = habit.currentStreak;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: AppStyles.whiteColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppStyles.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(
            habit.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              '🔥 Streak: $streak   •   ⏱️ ${habit.frequency.capitalize()}',
              style: TextStyle(fontSize: 14, color: AppStyles.lightTextColor),
            ),
          ),
          trailing: Container(
            decoration: BoxDecoration(
              color: isCompletedToday ? Colors.grey[400] : Colors.green[600],
              borderRadius: BorderRadius.circular(24),
            ),
            child: InkWell(
              onTap: isCompletedToday ? null : onComplete,
              borderRadius: BorderRadius.circular(24),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCompletedToday ? Icons.check_circle_outline : Icons.check,
                      size: 18,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCompletedToday ? 'Done' : 'Mark Done',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppStyles.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
