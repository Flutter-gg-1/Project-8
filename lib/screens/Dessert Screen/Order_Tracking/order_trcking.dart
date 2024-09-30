import 'package:flutter/material.dart';

class OrderTracking extends StatefulWidget {
  const OrderTracking({super.key});

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
      body: Stack(
        children: [
          // خلفية عصرية
          Container(
            width: double.infinity,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff74a0b2),
                  Colors.white,
                ],
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: size.width * 0.85, // تكبير العرض قليلاً
                child: Stepper(
                  type: StepperType.vertical, // Stepper طولي عصري
                  currentStep: _currentStep,
                  onStepTapped: (step) {
                    setState(() {
                      _currentStep = step;
                    });
                  },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return const SizedBox.shrink(); // إخفاء أزرار Stepper
                  },
                  steps: [
                    Step(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 10),
                          const Text(
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
                      isActive: _currentStep >= 0,
                      state: _currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.local_cafe_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 10),
                          const Text(
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
                      isActive: _currentStep >= 1,
                      state: _currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: Row(
                        children: [
                          const Icon(
                            Icons.delivery_dining,
                            color: Colors.blueAccent,
                          ),
                          const SizedBox(width: 10),
                          const Text(
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
                      isActive: _currentStep >= 2,
                      state: _currentStep == 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
