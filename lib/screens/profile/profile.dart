import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/profile/profile_item.dart';
import 'package:onze_cafe/services/setup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/Group 3155.png',
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: size.width * 0.2,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        backgroundColor: Colors.grey[300],
                        child: _image == null
                            ? Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: size.width * 0.1,
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        ProfileItem(
                          label: 'Name',
                          initialValue: locator.get<DataLayer>().user!.name,
                          size: size,
                        ),
                        const SizedBox(height: 20),
                        // Email
                        // ProfileItem(
                        //   label: 'Email',
                        //   initialValue: locator.get<DataLayer>().user!.email,
                        //   size: size,
                        // ),
                        const SizedBox(height: 20),
                        // Phone Number
                        ProfileItem(
                          label: 'Phone Number',
                          initialValue: locator.get<DataLayer>().user!.phone,
                          size: size,
                        ),
                        const SizedBox(height: 30),
                        // Password Field and Save Button
                        // const Text(
                        //   'Reset Password',
                        //   style: TextStyle(color: Colors.white70, fontSize: 16),
                        // ),
                        // const SizedBox(height: 10),
                        // // Password Input Field
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xff141415).withOpacity(0.7),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: TextFormField(
                        //     controller: _passwordController,
                        //     obscureText: true,
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: size.width * 0.045,
                        //     ),
                        //     decoration: const InputDecoration(
                        //       hintText: 'Enter new password',
                        //       hintStyle: TextStyle(color: Colors.white70),
                        //       contentPadding: EdgeInsets.symmetric(
                        //           horizontal: 15, vertical: 15),
                        //       border: InputBorder.none,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 20),
                        // Save Button
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffbc793d),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.3, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {


                              
                              // Save password functionality
                              // final password = _passwordController.text;
                              // if (password.isNotEmpty) {
                              //   // Implement your password save logic here
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content: Text('Password saved!')),
                              //   );
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //         content: Text('Enter a valid password!')),
                              //   );
                              // }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


