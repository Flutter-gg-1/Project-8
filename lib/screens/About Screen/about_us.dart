import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:onze_cafe/screens/About%20Screen/branch_card.dart';
import 'package:onze_cafe/utils/launch_url.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/logo-h-white.png',
      'assets/Layer.png',
      'assets/OIP 1.png'
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff3D6B7D),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About us',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffA8483D),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Who are we?',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff2F4B4E),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            RichText(
              textAlign: TextAlign.left,
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
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.left,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Our Coffee Standards: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff2F4B4E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We go beyond the conventional quality standards in the world of specialty coffee. Every type of coffee we offer must score 80 points or higher on a 100-point scale to ensure its excellence. We meticulously select coffee that scores 84 points or above, ensuring an exceptional flavor experience for our customers.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff2F4B4E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We go beyond the conventional quality standards in the world of specialty coffee. Every type of coffee we offer must score 80 points or higher on a 100-point scale to ensure its excellence. We meticulously select coffee that scores 84 points or above, ensuring an exceptional flavor experience for our customers.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xff2F4B4E),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            const Text(
              'Our branches',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffA8483D),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              'Located at!',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffA8483D),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return BranchCard(image: images[index]);
                  })),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        height: 110,
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xff3D6B7D)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Bootstrap.tiktok,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          launchURL('https://www.tiktok.com/@onze.sa');
                        },
                        child: const Text('onze.s',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Bootstrap.whatsapp,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          launchURL(
                              'https://api.whatsapp.com/send/?phone=0504142366&text&type=phone_number&app_absent=0');
                        },
                        child: const Text('0504142366',
                            style: TextStyle(color: Colors.white))),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Bootstrap.snapchat,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        onTap: () {
                          launchURL('https://www.snapchat.com/add/onzecafe');
                        },
                        child: const Text('onzecafe',
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Bootstrap.instagram,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      onTap: () {
                        launchURL('https://www.instagram.com/onze_sa/');
                      },
                      child: const Text(
                        'onzecafe',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('For more Information visit our webcite: '),
              InkWell(
                  onTap: () {
                    launchURL('https://onze.cafe/');
                  },
                  child:
                      const Text('here', style: TextStyle(color: Colors.blue))),
            ])
          ],
        ),
      ),
    );
  }
}
