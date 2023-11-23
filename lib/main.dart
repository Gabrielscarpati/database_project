import 'package:database_project/providers/logInSignUpProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'LogIn/viewLogIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qoeeknonbljllgcitofb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFvZWVrbm9uYmxqbGxnY2l0b2ZiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc5Mjg3MzIsImV4cCI6MjAxMzUwNDczMn0.s-EJqv90oepVOg4y2UHfwpRGVx0P4eX3UnTlb4m8vkY',
  );

  /*final supabase = Supabase.instance.client;
  Map<String, dynamic> params = {'usrId': '123n2n3e2mk3s23'};
  dynamic response = await supabase.rpc('aaa', params: params);
  print('RPC Response: ${response}');*/
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LogInSignUpProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewLogIn(),
    );
  }
}
