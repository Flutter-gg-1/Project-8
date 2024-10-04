import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff3D6B7D),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const Text(
            'About us',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xffA8483D),
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Who are we?',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff2F4B4E),
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
              text: const TextSpan(
            children: [
              TextSpan(
                text: 'At Onze Cafe, ',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff2F4B4E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    'we specialize in offering a unique coffee experience that takes your refined taste into account. Whether you lean towards bold coffee blends or prefer the bright flavors of lightly roasted single-origin beans, we are here to help you discover your favorite flavors, whatever your mood might be. And if you\'re unsure about your coffee preference, don\'t worry—our expert team is here to guide you to the perfect choice.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff2F4B4E),
                ),
              ),
            ],
          )),
          const SizedBox(
            height: 20,
          ),
          RichText(
              text: const TextSpan(
            children: [
              TextSpan(
                text: 'Our Coffee Standards: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff2F4B4E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text:
                    'We go beyond the conventional quality standards in the world of specialty coffee. Every type of coffee we offer must score 80 points or higher on a 100-point scale to ensure its excellence. We meticulously select coffee that scores 84 points or above, ensuring an exceptional flavor experience for our customers.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff2F4B4E),
                ),
              ),
            ],
          )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'We go beyond the conventional quality standards in the world of specialty coffee. Every type of coffee we offer must score 80 points or higher on a 100-point scale to ensure its excellence. We meticulously select coffee that scores 84 points or above, ensuring an exceptional flavor experience for our customers.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff2F4B4E),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Column(
            children: [
              Text(
                'Our branches',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffA8483D),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Located at!',
                style: TextStyle(fontSize: 20, color: Color(0xffA8483D)),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xff87B1C5)),
              )
            ],
          )
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        height: 110,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xff3D6B7D)),
      ),
    );
  }
}
