import 'dart:io';
import 'package:MyMedice/src/constants/colors.dart';
import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selectedImagePath = '';
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(tEditProfile, style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: selectedImagePath == ''
                            ? Image.asset(
                                tProfileImagePlaceHolder,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(selectedImagePath),
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor),
                      child: IconButton(
                        onPressed: () async {
                          selectImage();
                          setState(() {});
                        },
                        icon: const Icon(LineAwesomeIcons.camera,
                            color: Colors.black, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text(tFullName),
                          prefixIcon: Icon(LineAwesomeIcons.user)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      validator: (email) =>
                          email != null && EmailValidator.validate(email)
                              ? 'Enter a valid Email'
                              : null,
                      decoration: const InputDecoration(
                          label: Text(tEmail),
                          prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text(tPhoneNo),
                          prefixIcon: Icon(LineAwesomeIcons.phone)),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        label: const Text(tPassWord),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                            icon: Icon(_obscureText
                                ? LineAwesomeIcons.eye_slash
                                : LineAwesomeIcons.eye),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const UpdateProfileScreen()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text(tEditProfile,
                            style: TextStyle(color: tDarkColor)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: tJoined,
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: tJoinedAt,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text(tDelete),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Selected !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      tGallery,
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            if (selectedImagePath != '') {
                              Get.back(canPop: false);
                              setState(() {});
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context)
                                  // ignore: prefer_const_constructors
                                  .showSnackBar(SnackBar(
                                content: const Text("No Image Captured !"),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      tCamera,
                                      height: 40,
                                      width: 40,
                                    ),
                                    const Text('Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  //
  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
}
