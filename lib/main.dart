import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';

import 'MessageScreen.dart';
import 'bloc/message/message_bloc.dart';
import 'bloc/message/message_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Telephony telephony = Telephony.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => MessageBloc()..add(FetchMessages()),
        // create: (context) => MessageBloc(telephony)..add(FetchMessages()),
        child: MessageScreen(),
      ),
    );
  }
}
