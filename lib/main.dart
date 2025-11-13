// ...existing code...
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// ...existing code...

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
      child: Consumer<MyAppState>(
        builder: (context, appState, _) {
          return MaterialApp(
            title: 'GetFlora',
            theme: appState.darkMode 
            ? ThemeData(
                brightness: Brightness.dark,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 20, 40, 10),
                  brightness: Brightness.dark
                ),
            ) : ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 20, 40, 10),
                  brightness: Brightness.light
            ),
          ),
          home: MyHomePage(),        
          );
        }
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  bool darkMode = true;
  String? selectedImagePath;

  void toggleDarkMode() {
    darkMode = !darkMode;
    notifyListeners();
  } 
  Future<void> pickImage(ImageSource source) async {
    try {

      // Read bytes from the file object
      

      // base64 encode the bytes
      final picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
      );
      if (file == null) {
        // user cancelled
        return;
      }
      Uint8List bytes = await file.readAsBytes();
      String base64String = base64.encode(bytes);
      selectedImagePath = file.path;
      notifyListeners();
    } catch (e) {
      // simple error logging
      print('pickImage error: $e');
    }
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();
    var defaultRemote = 'https://just-rooibos.com/wp-content/uploads/2019/04/rooibos-flower.jpg';
    String? plantPic = appState.selectedImagePath ?? defaultRemote;

    Widget imageWidget;
    if (appState.selectedImagePath != null) {
      imageWidget = Image.file(
        File(plantPic),
        height: 200,
        width: 300,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Image.network(
        plantPic,
        height: 200,
        width: 300,
        fit: BoxFit.cover,
      );
    }

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

              Card(
                child: imageWidget,
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const btnGetInfo(),
                  btnCapture(),
                ],
              ),
              const SizedBox(height: 250),
              Padding(
                padding: const EdgeInsets.fromLTRB(250, 0, 0, 0),
                child: btnLightDark(),
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
          },
          child: const Text('Get Info'),
        ),
    );
  }
}

class btnLightDark extends StatelessWidget {
  const btnLightDark({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            print('button pressed!');
            context.read<MyAppState>().toggleDarkMode();
          },
          child: context.watch<MyAppState>().darkMode
            ? const Text('☀')
            : const Text('🌙'),
        ),
    );
  }
}

class btnCapture extends StatelessWidget {
  const btnCapture({
    super.key,
  });

  Future<void> _showPickOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  context.read<MyAppState>().pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  context.read<MyAppState>().pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            _showPickOptions(context);
          },
          child: const Text('Capture'),
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
// ...existing code...