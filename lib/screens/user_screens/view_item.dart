import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/extensions/screen_size.dart';
import 'package:project8/models/item_model.dart';

class ViewItem extends StatelessWidget {
  final ItemModel item;
  const ViewItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      appBar: AppBar(
        backgroundColor: AppConstants.mainlightBlue,
        leading: IconButton(
          onPressed: ()=>context.pop(),
          icon: const Icon(Icons.arrow_back_ios,color: AppConstants.mainWhite)
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_rounded,color: AppConstants.mainWhite,size: 28)
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              // blue oval
              ClipPath(
                clipper: CustomShapeClipper(),
                child: Container(height: 300.0,color: AppConstants.mainlightBlue,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // stars
                    Row(
                      children: [
                        const SizedBox(width: 250),
                        Image.asset('assets/images/stars.png'),
                      ],
                    ),
                    Center(child: Image.network(item.image)),
                    const SizedBox(height: 10),
                    Text(
                      item.name,
                      style: const TextStyle(fontSize: 24,fontFamily: 'Average',color: AppConstants.textColor,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.fireFlameCurved,size: 15,color: AppConstants.mainRed,),
                        const SizedBox(width: 5),
                        Text(
                          '${item.calories} Cal.',
                          style: const TextStyle(fontSize: 18,fontFamily: 'Average',color: AppConstants.textColor,),
                        ),
                        const Spacer(),
                        Text(
                          '${item.price} SAR',
                          style: const TextStyle(fontFamily: 'Average',color: AppConstants.textColor,fontSize: 18,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.description,
                      // 'A delightful coffee brewing method that combines the clarity and complexity of pour-over coffee with the refreshing chill of iced beverages.',
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontSize: 16,color: AppConstants.textColor,fontFamily: 'Average',),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: context.getWidth(divideBy: 1.8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.mainBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "add to cart",
                      style: TextStyle(color: AppConstants.mainWhite),
                    )
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {},
                ),
                const Text('1', style: TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      )
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.7);
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}