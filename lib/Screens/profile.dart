// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_user/config/styles.dart';
import 'package:skill_share_user/firebase/functions.dart';

class Profile extends StatefulWidget {
  const Profile({super. key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController textEditingController = TextEditingController();
  File? imageFile;

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }
  void showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit usernme"),
          content: TextField(
            controller: textEditingController,
            decoration: const InputDecoration(
              hintText: "Enter new username",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async{
              await updateprofile({
                "username":textEditingController.text.trim()
              });
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: StreamBuilder(
        stream: firestore
            .collection("users")
            .where("email", isEqualTo: auth.currentUser?.email)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final userData = snapshot.data?.docs.isNotEmpty ?? false
              ? snapshot.data!.docs.first.data()
              : null;

          if (userData == null) {
            return const Center(
              child: Text('No user data found.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                          child: CircleAvatar(
                            backgroundImage: userData["image"] == null
                                ? const AssetImage("assets/user (2).png")
                                    as ImageProvider<Object>
                                : NetworkImage(userData["image"])
                                    as ImageProvider<Object>,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () async{
                            await pickImage();
                           final image = await uploadFileToFirebase(imageFile!);
                           await updateprofile({"image":image});
                            },
                            icon: const Icon(Icons.add_a_photo,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Username",
                        style: Styles.subtitlegrey(context),
                      ),
                      IconButton(
                        onPressed: () {
                            showEditDialog();
                        },
                        icon: const Icon(Icons.edit, color: Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["username"] ?? "Username",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email",
                        style: Styles.subtitlegrey(context),
                      ),
                    
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      userData["email"] ?? "Email",
                      style: Styles.labelText(context),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
