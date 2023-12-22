import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notely_app/controller/note_card_controller.dart';
import 'package:notely_app/controller/search_controller.dart';
import 'package:notely_app/model/note_card_model.dart';
import 'package:notely_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteCardModelAdapter());
  await Hive.openBox<NoteCardModel>('testBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SearchScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NoteCardController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
