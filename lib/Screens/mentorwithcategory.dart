import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_user/Screens/mentorprofile.dart';
import 'package:skill_share_user/config/styles.dart';
import 'package:skill_share_user/firebase/functions.dart';

class MentorByCategory extends StatelessWidget {
  final String categorie;
  const MentorByCategory({super.key, required this.categorie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$categorie Mentors"
        ),
      ),
      body: StreamBuilder(
        stream: firestore
            .collection("veterans")
            .where("type", isEqualTo: categorie)
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

          final mentors = snapshot.data?.docs ?? [];

          if (mentors.isEmpty) {
            return const Center(
              child: Text('No mentors found.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: ListView.builder(
              itemCount: mentors.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Map<String, dynamic>> mentorDoc =
                    mentors[index];
                Map<String, dynamic> data = mentorDoc.data();
                return Column(
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
                                MentorProfile(email: data["email"],),
                        ),
                      );
                    },
                    leading: Image.asset("assets/graduation.png"),
                    title: Text(data["username"],style: Styles.subtitle(context),),
                  ),
                ),
              ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}