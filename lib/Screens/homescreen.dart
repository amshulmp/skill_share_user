// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:skill_share_user/Screens/categories.dart';
import 'package:skill_share_user/Screens/login.dart';
import 'package:skill_share_user/Screens/mentees.dart';
import 'package:skill_share_user/Screens/profile.dart';
import 'package:skill_share_user/Screens/videomentor.dart';
import 'package:skill_share_user/config/styles.dart';
import 'package:skill_share_user/firebase/functions.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),
      actions:  [
        IconButton(onPressed: ()async{
          await signout();
          Navigator.popUntil(context, (route) => route.isFirst);
           Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const LoginScreen(),
                        ),
                      );
        }, icon: const Icon(Icons.logout,color: Colors.black,))
      ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  17.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                       onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Mentorss(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/graduation.png"),
                    title: Text("Your Mentors",style: Styles.subtitle(context),),
                   
                  ),
                ),
              ),
               
           
                SizedBox(height: MediaQuery.of(context).size.height * 0.013),
               Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                       onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Categories(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/search.png"),
                    title: Text("Find Mentors",style: Styles.subtitle(context),),
                   
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                  onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Videomentor(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/video-marketing.png"),
                    title: Text("Mentor Videos",style: Styles.subtitle(context),
                    ),
                      
                  ),
                ),
              ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.013),
                Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                  onTap: (){
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Profile(),
                        ),
                      );
                    },
                    leading: Image.asset("assets/user (2).png"),
                    title: Text("Profile",style: Styles.subtitle(context),
                    ),
                      
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}