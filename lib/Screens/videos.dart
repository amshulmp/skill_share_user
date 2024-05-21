import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_user/Screens/player.dart';
import 'package:skill_share_user/config/styles.dart';
import 'package:skill_share_user/firebase/functions.dart';

class Videos extends StatelessWidget {
  final String email;
  const Videos({super.key, required this.email });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Videos")),
      body: StreamBuilder(
        stream: firestore
            .collection("videos")
            .where("traineremail", isEqualTo: email)
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
      
          if (snapshot.data?.docs.isEmpty ?? true) {
            return const Center(
              child: Text(
                'No videos found.',
                style: TextStyle(fontSize: 18.0),
              ),
            );
          }
      
          return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                var videoData = snapshot.data!.docs[index].data();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewVideo(video: Uri.parse(videoData["url"])),
                            ),
                          );
                        },
                        leading: Image.asset("assets/video-marketing.png"),
                        title: Text(
                          videoData["title"] ?? "Untitled",
                          style: Styles.subtitle(context),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
