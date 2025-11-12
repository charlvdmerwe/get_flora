import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

Future<void> getPlantInfo() async {
    var headers = {
    'Api-Key': 'ke6I00uIeq04fIa4iBNbc7Wqru3haa9jCMJeNtZpk7GD1Wm02t',
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://plant.id/api/v3/identification'));
  request.body = json.encode({
    "images": [
      "https://plant.id/static/oak.jpg"
    ],
    "latitude": 49.207,
    "longitude": 16.608,
    "similar_images": true
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 201) {
    // var message = response.stream.bytesToString();
    print(await response.stream.bytesToString());
  }
  else {
    print(response.reasonPhrase);
  }

  print(response);

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [Text('A random idea:'),
        
        ElevatedButton(
            onPressed: () {
              print('button pressed!');
              // getPlantInfo();
            },
            child: Text('Next'),
          ),

        ],
      ),
    );
  }
}
