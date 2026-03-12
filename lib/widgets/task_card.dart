import 'package:flutter/material.dart';
import '../app/theme.dart';
import 'member_avatar.dart';
import 'progress_circle.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final List<String> memberAvatars;
  final double progress;
  final String? dueDate;
  final bool isCompleted;
  final VoidCallback? onTap;

  const TaskCard({
    super.key,
    required this.title,
    required this.memberAvatars,
    required this.progress,
    this.dueDate,
    this.isCompleted = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 160,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted ? AppTheme.accentColor : AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title - Fixed height
            SizedBox(
              height: 40,
              child: Text(
                title,
                style: TextStyle(
                  color: isCompleted ? Colors.black : AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            
            // Team members section - Fixed height
            SizedBox(
              height: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Team members',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...memberAvatars.take(3).map(
                        (avatar) => MemberAvatar(
                          name: avatar,
                          size: 20,
                        ),
                      ),
                      if (memberAvatars.length > 3)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppTheme.textSecondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '+${memberAvatars.length - 3}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            
            // Progress section - Fixed height
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isCompleted ? 'Completed' : 'Progress',
                          style: TextStyle(
                            color: isCompleted ? Colors.black54 : AppTheme.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (dueDate != null)
                          Text(
                            'Due: $dueDate',
                            style: TextStyle(
                              color: isCompleted ? Colors.black54 : AppTheme.textSecondary,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  ProgressCircle(
                    progress: progress,
                    size: 40,
                    strokeWidth: 3,
                    backgroundColor: isCompleted 
                        ? Colors.black.withOpacity(0.2)
                        : AppTheme.textSecondary.withOpacity(0.3),
                    progressColor: isCompleted ? Colors.black : AppTheme.accentColor,
                    showPercentage: true,
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