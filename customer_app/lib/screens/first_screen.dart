import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: context.getHeight(multiply: 0.05),top: context.getHeight(multiply: 0.1)),
      decoration: const BoxDecoration(
          color: Color(0xffD7D1CA),
          image: DecorationImage(
            image: AssetImage('assets/image/first.png'),
          )),
      child: Scaffold(
        floatingActionButton:  CustomButton(
                title: 'Get Coffee',
                icon: Icons.arrow_forward_ios_rounded,
                onPressed: (){},
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/image/logo.png'),
              context.addSpacer(),
              
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function() onPressed;
  const CustomButton({
    super.key, required this.title, this.icon,required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(context.getWidth(multiply: 0.6),
              context.getHeight(multiply: 0.06)),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9)),
          backgroundColor: const Color(0xffA8483D),
        ),
        onPressed: onPressed,
        child:  Row(
          children: [
            const Spacer(),
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const Spacer(),
            Icon(
              icon,
              color: Colors.white,
            )
          ],
        ));
  }
}
