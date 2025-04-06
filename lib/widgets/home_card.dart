import 'package:flutter/material.dart';

class HomeCart extends StatelessWidget {
  HomeCart({super.key, required this.data});


  final Map data ;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white, width: 1.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/no_image.png'),
            ),
            Text(
              data['name'],
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              data['location'],
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              data['job'],
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text('Degree Required:No', style: TextStyle(color: Colors.teal)),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('Open Chat'),
            ),
          ],
        ),
      ),
    );
  }
}
