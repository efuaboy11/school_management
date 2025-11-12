import 'package:flutter/material.dart';
import 'package:mobile_app/theme.dart';

class SchoolEventDetails extends StatelessWidget{
  const SchoolEventDetails({super.key,
    required this.productId,
    required this.productName,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.rating,
    required this.measurementDetails,
    required this.image,
    required this.imageTwo,
    required this.imageThree,

  });

  final int productId;
  final String productName;
  final String description;
  final String price;
  final String discountPrice;
  final String rating;
  final List<dynamic> measurementDetails;
  final dynamic image;
  final dynamic imageTwo;
  final dynamic imageThree;






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

                
              ],
            ),
          ),
        );
      }
    );
  }
}