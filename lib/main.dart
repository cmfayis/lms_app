import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_app/blocs/module/bloc/module_bloc.dart';
import 'package:lms_app/blocs/subject/bloc/subject_bloc.dart';
import 'package:lms_app/blocs/video/bloc/video_bloc.dart';
import 'package:lms_app/data/api_client.dart';
import 'package:lms_app/presentation/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SubjectBloc(ApiClient())..add(FetchSubjects()),
        ),
        BlocProvider(create: (context) => ModuleBloc(ApiClient())),
        BlocProvider(create: (context) => VideoBloc(ApiClient())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learning Management System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
      ),
    );
  }
}
