import 'package:flutter/material.dart';
import 'package:mobile_app/theme.dart';

class ClassNotificationDetails extends StatelessWidget {
  final String subject;
  final String body;
  final String teacherPosted;
  final DateTime datePosted;
  final bool isRead;

  ClassNotificationDetails({
    super.key,
    this.subject = "System Maintenance",
    this.body = "We will be performing maintenance on the system between 12:00 AM and 2:00 AM. Please save your work.",
    this.teacherPosted = 'Iseghohimhen Efua',
    DateTime? datePosted,
    this.isRead = false,
  }) : datePosted = datePosted ?? DateTime(2025, 10, 5, 10, 0);

  @override
  Widget build(BuildContext context) {
    final formattedDate = "${datePosted.day}/${datePosted.month}/${datePosted.year} ${datePosted.hour}:${datePosted.minute.toString().padLeft(2, '0')}";
        final customColors = Theme.of(context).extension<CustomColors>()!;
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header line
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Subject
                Text(
                  subject,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Date & Read Status
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: customColors.lightText),
                    const SizedBox(width: 4),
                    Text(
                      formattedDate,
                      style: TextStyle(color: customColors.lightText),
                    ),

                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: customColors.lightBorder,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(isRead ? Icons.notifications : Icons.notifications_outlined, size: 12,),
                          SizedBox(width: 10,),
                          Text(
                            isRead ? "Read" : "Unread",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Text(
                  'Posted by: $teacherPosted',
                  style: TextStyle(color: customColors.lightText),
                ),

                const SizedBox(height: 20),

                // Body
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
