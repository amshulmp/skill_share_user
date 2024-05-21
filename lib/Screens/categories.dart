import 'package:flutter/material.dart';
import 'package:skill_share_user/Screens/mentorwithcategory.dart';
import 'package:skill_share_user/config/styles.dart';
class Categories extends StatelessWidget {
  const Categories({super. key});

  @override
  Widget build(BuildContext context) {
    List<String> skillCategories = [
      'Music',
      'Education',
      'Dance',
      'Art',
      'Sports',
      'Cooking',
      'Programming',
      'Writing',
      'Design',
      'Fitness'
    ];
    List<String> images = [
      "assets/musical-note.png",
      "assets/homework.png",
      "assets/dance.png",
      "assets/art.png",
      "assets/basketball.png",
      "assets/cooking.png",
      "assets/programming.png",
      "assets/pencil.png",
      "assets/graphic-designer.png",
      "assets/fitness (2).png"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: ListView.builder(
        itemCount: skillCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.013),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MentorByCategory(
                            categorie: skillCategories[index],
                          ),
                        ),
                      );
                    },
                    leading: Image.asset(images[index]),
                    title: Text(
                      skillCategories[index],
                      style: Styles.subtitle(context),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
