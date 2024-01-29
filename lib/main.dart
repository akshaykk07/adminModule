import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled10/adminModule/AddNote/NoteList.dart';
import 'package:untitled10/adminModule/AddNote/addNotes.dart';
import 'package:untitled10/adminModule/adminDash.dart';
import 'package:untitled10/test.dart';
import 'package:untitled10/test2.dart';


import 'adminModule/Banner/bannerList.dart';
import 'adminModule/Student/studentList.dart';
import 'adminModule/Student/viewStudent.dart';
import 'adminModule/Banner/addBanners.dart';

import 'firebase_options.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) => 
       MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:AdminDash()
      ),
      designSize: Size(390, 844),
    );
  }
}

