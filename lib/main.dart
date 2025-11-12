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
    'Api-Key': 'MyKeyHere',
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

  if (response.statusCode == 201 || response.statusCode == 200) {
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
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 83, 115, 58)),
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

    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    var plantPic = 'https://just-rooibos.com/wp-content/uploads/2019/04/rooibos-flower.jpg';

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              
              const SizedBox(height: 32),

              Image.network(  
                'https://media.discordapp.net/attachments/1241079742250352715/1438279553280774374/ChatGPT_Image_Nov_12__2025__11_12_53_PM-removebg-preview.png?ex=69164db7&is=6914fc37&hm=81b5d16644d4e5cc34d5f70eb2d6ad338fe0e30de1d0d4238171359ebb9f3b37&=&format=webp&quality=lossless',
                height: 100,
                width: 300,
              ),  

              Image.network(  
                plantPic,
                height: 300,
                width: 300,
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  btnCapture(),
                  btnGetInfo(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class btnGetInfo extends StatelessWidget {
  const btnGetInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            print('button pressed!');
            // getPlantInfo();
          },
          child: Text('Get Info'),
        ),
    );
  }
}

class btnCapture extends StatelessWidget {
  const btnCapture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            print('button pressed!');
            // getPlantInfo();
          },
          child: Text('Capture'),
        ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var textStyle = theme.textTheme.headlineLarge!
        .copyWith(color: theme.colorScheme.onPrimary);

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('GetFlora', style: textStyle)),
      ),
    );
  }
}
