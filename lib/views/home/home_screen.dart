import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final List<Map<String, String>> jobDataList = [
    {
      'name': 'Margarita',
      'location': 'San Francisco, 34 5th St',
      'interests': "Interesting jobs: I'm opened to any suggestion",
      'degree': 'Degree Required - No',
    },
    {
      'name': 'John Doe',
      'location': 'New York, 123 Main St',
      'interests': "Looking for software engineering roles",
      'degree': 'Degree Required - Yes',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'JobSky',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 380,
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[100]!,
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                              ),
                            ]
                          ),
                          child: Card(
                            color:  Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage('assets/images/no_image.png'),
                                  ),
                                  Text(
                                    'Margarita',
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'San Francisci. 34 5th St',
                                    style: TextStyle(color: Colors.grey[600]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Interesting jobs: I\'m opened to any suggestion',
                                    style: TextStyle(color: Colors.grey[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    'Degree Required:No',
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.refresh, color: Colors.green),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle open chat
                                        },
                                        child: const Text('Open Chat'),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: Colors.grey[200],
                                        child: Icon(Icons.close, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ]
                              )
                          )),
                        ),
                      )
                    ],
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
