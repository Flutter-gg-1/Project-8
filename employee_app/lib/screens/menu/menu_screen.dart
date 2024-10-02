import 'package:employee_app/data_layer/product_layer.dart';
import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/product_model.dart';
import 'package:employee_app/models/user_model.dart';
import 'package:employee_app/screens/profile/profile_screen.dart';
import 'package:employee_app/services/setup.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final locator = productLocator.get<ProductLayer>();
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      //separate it later
      drawer: Drawer(
        backgroundColor: const Color(0xffD7D1CA),
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: context.getWidth(multiply: 0.02),
            vertical: context.getHeight(multiply: 0.1),
          ),
          child: Column(
            children: [
              Image.asset('assets/image/logo.png'),
              context.addSpacer(multiply: 0.02),
              Text(
                'Welcome ${user.firstName}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Rosarivo'),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: context.getWidth(multiply: 0.05),
                  vertical: context.getWidth(multiply: 0.05),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: context.getWidth(multiply: 0.05),
                  vertical: context.getWidth(multiply: 0.02),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: kElevationToShadow[4],
                  color: const Color(0xffEFEDEA),
                ),
                child: const Text(
                  'Onze Cafe\nWhere Artisanal Coffee\nMeets a Warm, Inviting\nAtmosphere — A Place to Savor Handcrafted Beverages and Build Lasting Connections',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Rosarivo'),
                ),
              ),
              context.addSpacer(multiply: 0.03),
              CustomButton(
                title: '     Profile',
                onPressed: () {
                  // navigate to profile
                },
                fixedSize: Size(context.getWidth(multiply: 0.4),
                    context.getHeight(multiply: 0.06)),
              ),
              context.addSpacer(multiply: 0.03),
              // CustomButton(
              //   title: '   My Order',
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const CartScreen(),
              //         ));
              //   },
              //   fixedSize: Size(context.getWidth(multiply: 0.4),
              //       context.getHeight(multiply: 0.06)),
              // ),
              // context.addSpacer(multiply: 0.03),
              // CustomButton(
              //   title: '    History',
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const HistoryScreen(),
              //         ));
              //   },
              //   fixedSize: Size(context.getWidth(multiply: 0.4),
              //       context.getHeight(multiply: 0.06)),
              // ),
              context.addSpacer(multiply: 0.08),
              CustomButton(
                title: '     Logout',
                titleColor: Colors.grey,
                onPressed: () {},
                fixedSize: Size(context.getWidth(multiply: 0.4),
                    context.getHeight(multiply: 0.06)),
              ),
              context.addSpacer(multiply: 0.04),
              const Text(
                'Version: 1.0.0',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Rosarivo'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Image.asset('assets/image/logo_small.png'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              FontAwesome.bars_staggered_solid,
              color: Color(0xffA8483D),
            )),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
            },
            child: const CircleAvatar(
              backgroundColor: Color(0xffd9d9d9),
              backgroundImage: AssetImage('assets/image/appBarProfile.png'),
            ),
          ),
          SizedBox(
            width: context.getWidth(multiply: 0.03),
          )
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight * 0.8,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getWidth(multiply: 0.05),
                  vertical: context.getHeight(multiply: 0.02),
                  ),
              child: Center(
                child: Column(children: [
                  Image.asset('assets/image/menulogo.png'),
                  context.addSpacer(multiply: 0.04),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: locator.menu.length,
                      itemBuilder: (context, index) => MenuItem(
                        itemInfo: locator.menu[index],
                        editFunction: () {},
                        removeFunction: () {},
                      ),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final Function()? editFunction;
  final Function()? removeFunction;
  final ProductModel itemInfo;
  const MenuItem({
    super.key,
    this.editFunction,
    this.removeFunction,
    required this.itemInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(multiply: 0.4),
      padding: EdgeInsets.symmetric(
        vertical: context.getWidth(multiply: 0.02),
        horizontal: context.getWidth(multiply: 0.02),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffEFEDEA),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: editFunction,
                icon: const Icon(
                  Icons.edit,
                  color: Color(0xff3D6B7D),
                ),
              ),
              IconButton(
                onPressed: removeFunction,
                icon: const Icon(
                  Icons.highlight_remove_rounded,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Image.asset('assets/image/menuImage.png'),
          context.addSpacer(multiply: 0.02),
          Text(
            '${itemInfo.name}',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontFamily: 'Rosarivo'),
          ),
        ],
      ),
    );
  }
}
