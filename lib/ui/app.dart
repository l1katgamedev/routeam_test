import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routeam_test/bloc/repos.dart';
import 'package:routeam_test/services/repository.dart';
import 'package:routeam_test/ui/screens/screens.dart';


class GitHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RepoBloc>(
          create: (context) => RepoBloc(Repos()),
        ),
      ],
      child: MaterialApp(
        title: 'GitHub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF1C2128),
        ),
        home: SplashScreen(),
      ),
    );
  }
}