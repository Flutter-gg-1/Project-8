import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/login_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Username',
                  style: TextStyle(color: Colors.white, fontSize: 14.33),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffA4A4A4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: nameController,
                    cursorColor: const Color(0xffE6E2E0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.person_2_outlined,
                          color: Color(0xffE6E2E0)),
                      hintText: 'Username',
                      hintStyle: const TextStyle(color: Color(0xffA4A4A4)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('Password',
                    style: TextStyle(
                        fontSize: 14.33,
                        color: Color(0xffE6E2E0),
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffA4A4A4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: const Color(0xffE6E2E0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                          width: 2,
                        ),
                      ),
                      prefixIcon:
                          const Icon(Icons.key, color: Color(0xffE6E2E0)),
                      suffixIcon: const Icon(Icons.visibility_off,
                          color: Color(0xffE6E2E0)),
                      hintText: '•••••••••',
                      hintStyle: const TextStyle(color: Color(0xffA4A4A4)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('email',
                    style: TextStyle(
                        fontSize: 14.33,
                        color: Color(0xffE6E2E0),
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffA4A4A4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    cursorColor: const Color(0xffE6E2E0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                          width: 2,
                        ),
                      ),
                      prefixIcon:
                          const Icon(Icons.alternate_email_outlined, color: Color(0xffE6E2E0)),
                      hintText: 'example@gmail.com',
                      hintStyle: const TextStyle(color: Color(0xffA4A4A4)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('Phone',
                    style: TextStyle(
                        fontSize: 14.33,
                        color: Color(0xffE6E2E0),
                        fontWeight: FontWeight.w600)),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffA4A4A4).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: phoneController,
                    obscureText: true,
                    cursorColor: const Color(0xffE6E2E0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xffE6E2E0),
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.phone_android,
                          color: Color(0xffE6E2E0)),
                      hintText: '05xxxxxxxx',
                      hintStyle: const TextStyle(color: Color(0xffA4A4A4)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                    height: 50,
                    width: 314,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xffE6E2E0), width: 1),
                        gradient: const LinearGradient(
                            colors: [Color(0xff2F4B4E), Color(0xffE6E2E0)]),
                        borderRadius: BorderRadius.circular(15)),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Center(
                        child: SizedBox.expand(
                          child: ElevatedButton(
                            onPressed: () {
                              // Register from DB
                              // Navigate to Login Screen
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.92,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
