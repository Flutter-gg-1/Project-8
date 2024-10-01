import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/screens/Order_Tracking/track_bloc/track_bloc.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => TrackBloc()..add(ReceivedEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Order Tracking',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xff74a0b2),
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<TrackBloc, TrackState>(
            builder: (context, state) {
               int currentStep = 0;

                    if (state is PrepareState) {
                      currentStep = 1;
                    }
                    
                    if (state is ReadyState) {
                      currentStep = 2;
                    }
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff74a0b2),
                          Colors.white,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: -150, child: Image.asset('assets/onze logo.png')),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: size.width * 0.85,
                        child: Stepper(
                          type: StepperType.vertical,
                          currentStep: currentStep,
                          controlsBuilder:
                              (BuildContext context, ControlsDetails details) {
                            return const SizedBox.shrink();
                          },
                          steps: [
                            Step(
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Order Received',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              content: const Text(
                                'Your order has been received.',
                                style: TextStyle(color: Colors.white70),
                              ),
                              isActive: currentStep >= 0,
                              state: currentStep > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.local_cafe_outlined,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Preparing Order',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              content: const Text(
                                'Your order is being prepared. Please wait...',
                                style: TextStyle(color: Colors.white70),
                              ),
                              isActive: currentStep >= 1,
                              state: currentStep > 1
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                            Step(
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.delivery_dining,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Your order is ready!',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              content: const Text(
                                'Your order has been delivered to the counter.',
                                style: TextStyle(color: Colors.white70),
                              ),
                              isActive: currentStep >= 2,
                              state: currentStep == 2
                                  ? StepState.complete
                                  : StepState.indexed,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
