import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class MenuTypes extends StatelessWidget {
  const MenuTypes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonsTabBar(
      buttonMargin: const EdgeInsets.only(left: 30),
      height: context.getHeight(multiply: 0.06),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      unselectedLabelStyle:
          const TextStyle(fontSize: 15, color: Color(0x37000000)),
      unselectedDecoration: BoxDecoration(
          color: const Color(0xff87B1C5),
          borderRadius: BorderRadius.circular(18)),
      decoration: BoxDecoration(
          color: const Color(0xffA8483D),
          borderRadius: BorderRadius.circular(12)),
      tabs: const [
        //?===============[type]=======================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/appBarProfile.png'),
          ),
          child: Text(
            'Classic Coffee',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]======================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/menu2.png'),
          ),
          child: Text(
            'Tea',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]=======================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/menucold.png'),
          ),
          child: Text(
            'Cold Drinks',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]=========================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/menucold.png'),
          ),
          child: Text(
            'drip coffee',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]========================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/water.png'),
          ),
          child: Text(
            'Water',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]========================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/appBarProfile.png'),
          ),
          child: Text(
            'Focaccia',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]=========================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/croissant.png'),
          ),
          child: Text(
            'croissant',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]===========================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/cookie.png'),
          ),
          child: Text(
            'cookies',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]============================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/cake1.png'),
          ),
          child: Text(
            'fennel cake',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        //?===============[type]===========================
        Tab(
          icon: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/image/cake3.png'),
          ),
          child: Text(
            'dessert',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
