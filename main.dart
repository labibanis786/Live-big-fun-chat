import 'package:flutter/material.dart';
import 'voice_room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big fun',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Big fun')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', width:120, height:120),
            const SizedBox(height:20),
            ElevatedButton(onPressed: (){}, child: const Text('Login (Phone OTP)')),
            const SizedBox(height:8),
            ElevatedButton(onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VoiceRoomPage())); }, child: const Text('Enter Voice Rooms')),
            const SizedBox(height:8),
            ElevatedButton(onPressed: (){}, child: const Text('Open Gifts')),
          ],
        ),
      ),
    );
  }
}
