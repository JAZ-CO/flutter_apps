import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<String> images = [
    "lib/images/shakshoka.jpg",
    "lib/images/shawarma.jpg",
    "lib/images/triple_chocCakejpg.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            //Title
            Text(
              "Tawseel",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold),
            ),
            // search Bar
            TextField(autofillHints: Iterable.generate(4)),

            // seperate line

            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            // List of Images
            SizedBox(
              height: 400,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Container(
                      //images of food
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          images[index],
                          height: 150.0,
                          width: 100.0,
                        ),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
