import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

class BillView extends StatelessWidget {
  const BillView({
    super.key,
    required this.brightness,
  });

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: G.primary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.close, color: C.bg1(brightness)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Text('Order #111').styled(
                  weight: FontWeight.bold, size: 24, color: C.bg1(brightness)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.black12)
                          ],
                          color: C.bg3(brightness),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.coffee,
                            color: C.accent(brightness),
                          ),
                        )),
                    Text("Americano X2").styled(
                      size: 16,
                      color: C.bg1(
                        brightness,
                      ),
                      weight: FontWeight.w700,
                    ),
                    Text("20 SAR").styled(
                      size: 16,
                      color: C.bg1(
                        brightness,
                      ),
                      weight: FontWeight.w800,
                    ),
                  ],
                ),
              )
            ]),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Divider(
                        color: C.bg1(brightness),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SubTotal").styled(
                            weight: FontWeight.w600,
                            size: 18,
                            color: C.bg1(
                              brightness,
                            ),
                          ),
                          Text("40 SAR").styled(
                            weight: FontWeight.w600,
                            size: 18,
                            color: C.bg1(
                              brightness,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax(15%)").styled(
                            weight: FontWeight.w600,
                            size: 18,
                            color: C.bg1(
                              brightness,
                            ),
                          ),
                          Text("2 SAR").styled(
                            weight: FontWeight.w600,
                            size: 18,
                            color: C.bg1(
                              brightness,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Price").styled(
                            weight: FontWeight.bold,
                            size: 24,
                            color: C.bg1(
                              brightness,
                            ),
                          ),
                          Text("40 SAR").styled(
                            weight: FontWeight.bold,
                            size: 24,
                            color: C.bg1(
                              brightness,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
