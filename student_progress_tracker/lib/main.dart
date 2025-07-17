import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as flutter_bloc;
import 'package:get/get.dart';
import 'package:student_progress_tracker/bloc/data_cubit.dart';
import 'package:student_progress_tracker/routes/routes.dart';
import 'package:student_progress_tracker/screens/login.dart';
import 'package:student_progress_tracker/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    flutter_bloc.MultiBlocProvider(
      providers: [
        flutter_bloc.BlocProvider(create: (_) => DataCubit()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      title: 'Student Progress Tracker',
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
    );
  }
}
