

import 'package:flutter/material.dart';
import 'package:mobile_app/theme.dart';

class SchoolEventDetails extends StatelessWidget{
  const SchoolEventDetails({super.key});

  @override
  Widget build(BuildContext context) {
        final customColors = Theme.of(context).extension<CustomColors>()!;
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController){
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),

          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                SizedBox(height: 12,),

                Text('School open day',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold), 
                ),

                SizedBox(height: 12,),

                Text(
                  'This is the school day open day, it will happen and interesting',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                ),

                SizedBox(height: 24,),

                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18, color: customColors.lightText,),
                    SizedBox(width: 8,),
                    Text('To: 25th nov, 2023')
                  ],
                ),

                SizedBox(height: 4,),
                    
                Row(
                  children: [
                    Icon(Icons.event, size: 16, color: customColors.lightText,),
                    SizedBox(width: 6,),
                    Text('To: 2nd april 2025')
                  ],
                )

              ],
            ),
          ),
        );
      }
    );
  }
}