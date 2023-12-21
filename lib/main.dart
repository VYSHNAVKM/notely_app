import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notely_app/model/note_card_model.dart';
import 'package:notely_app/view/bottom_bar_screen/bottom_bar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteCardModelAdapter());

  // Reopen 'testBox' with the correct type
  await Hive.openBox<NoteCardModel>('testBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomBarScreen(),
    );
  }
}
