import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/cart/cart_screen.dart';
import 'package:customer_app/screens/home/bloc/home_bloc.dart';
import 'package:customer_app/screens/menu/menu_option.dart';
import 'package:customer_app/screens/menu/menu_types.dart';
import 'package:customer_app/screens/order/order_info.dart';



import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/TextFormFeild/custom_text_form_feild.dart';
import 'package:customer_app/widget/drawer/home_drawer.dart';
import 'package:customer_app/widget/inkwell/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Builder(builder: (context) {
        final GlobalKey<ScaffoldState> scaffoldKey =
            GlobalKey<ScaffoldState>();
        final user = authLocator.get<AuthLayer>().user;
        TextEditingController searchController = TextEditingController();
        final bloc = context.read<HomeBloc>();
        return BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SearchResultNotFoundState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Product not found"),
                backgroundColor: Colors.red,
              ));
            }
            if (state is SearchSuccessFoundState) {
              showModalBottomSheet(
                context: context,
                builder: (context) => Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getWidth(multiply: 0.05),
                      vertical: context.getHeight(multiply: 0.05)),
                  height: context.getHeight(multiply: 0.4),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xff87B1C5),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/image/logo_small.png'),
                      context.addSpacer(multiply: 0.02),
                      SingleChildScrollView(
                        child: Column(
                          children: bloc.productSearchList
                              .map(
                                (e) => ProductItem(
                                  name: e.name!,
                                  price: e.price!,
                                  id: e.productId,
                                  cal: e.cal!,
                                  time: e.preparationTime!,
                                  description: e.des!,
                                  type: e.type!,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderInfo(product: e),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          child: DefaultTabController(
            length: 10,
            child: Scaffold(
              key: scaffoldKey,
              extendBodyBehindAppBar: true,
              drawer: HomeDrawer(user: user),
              appBar: AppBar(
                title: Image.asset('assets/image/logo_small.png'),
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(
                      FontAwesome.bars_staggered_solid,
                      color: Color(0xffA8483D),
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ));
                      },
                      icon: const Icon(
                        Iconsax.shop_add_bold,
                        color: Color(0xffA8483D),
                      )),
                  SizedBox(
                    width: context.getWidth(multiply: 0.01),
                  )
                ],
              ),
              body: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        floating: false,
                        expandedHeight: context.getHeight(multiply: 0.4),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Column(
                            children: [
                              SizedBox(
                                  height: context.getHeight(multiply: 0.1)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTextFormFelid(
                                  key: bloc.formKey,
                                  label: '',
                                  hint: 'Find your coffee',
                                  prefixIcon: const Icon(Bootstrap.search_heart),
                                  controller: searchController,
                                  onFieldSubmitted: (p0) {
                                    bloc.add(SearchEvent(searchValue: p0));
                                    bloc.productSearchList = [];
                                  },
                                ),
                              ),
                              Image.asset('assets/image/homegroup.png'),
                            ],
                          ),
                        ),
                        bottom: const PreferredSize(
                          preferredSize: Size.fromHeight(kToolbarHeight),
                          child: MenuTypes(),
                        ),
                      ),
                    ];
                  },
                  body: const SizedBox.shrink(child: MenuOption())),
            ),
          ),
        );
      }),
    );
  }
}
