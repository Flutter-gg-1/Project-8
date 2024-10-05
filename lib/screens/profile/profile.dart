import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/profile/bloc/profile_bloc.dart';
import 'package:onze_cafe/screens/profile/profile_item.dart';
import 'package:onze_cafe/services/setup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _pickImage(ProfileBloc bloc) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      bloc.add(UpdateImageEvent(File(pickedFile.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProfileBloc(
          locator.get<DataLayer>()), // Passing DataLayer to ProfileBloc
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile updated successfully')),
            );
          } else if (state is ProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final bloc = BlocProvider.of<ProfileBloc>(context);

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title:
                  const Text('Profile', style: TextStyle(color: Colors.white)),
            ),
            body: Stack(
              children: [
                // Background gradient
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff3D6B7D), Color(0xff87B1C5)],
                    ),
                  ),
                ),
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        // Profile Image
                        Center(
                          child: GestureDetector(
                            onTap: () => _pickImage(bloc),
                            child: CircleAvatar(
                              radius: size.width * 0.2,
                              backgroundImage: bloc.image != null
                                  ? FileImage(bloc.image!)
                                  : null,
                              backgroundColor: Colors.grey[300],
                              child: bloc.image == null
                                  ? Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: size.width * 0.1,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                                initialValue: bloc.name,
                                size: size,
                                onChanged: (value) =>
                                    bloc.add(UpdateNameEvent(value)),
                              ),
                              const SizedBox(height: 20),
                              // Phone Number
                              ProfileItem(
                                label: 'Phone Number',
                                initialValue: bloc.phone,
                                size: size,
                                onChanged: (value) =>
                                    bloc.add(UpdatePhoneEvent(value)),
                              ),
                              const SizedBox(height: 30),
                              // Save Button
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.3,
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {
                                    bloc.add(SaveProfileEvent());
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Color(0xff74a0b2),
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
        },
      ),
    );
  }
}
