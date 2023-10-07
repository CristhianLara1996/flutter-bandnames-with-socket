import 'package:band_names/src/pages/home_page.dart';
import 'package:band_names/src/pages/status_page.dart';
import 'package:band_names/src/pages/wrapper_detect.dart';
import 'package:band_names/src/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WrapperDetect(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SocketService(),
          ),
        ],
        child: MaterialApp(
          title: 'Band Names',
          initialRoute: 'home',
          routes: {
            'home': (context) => const HomePage(),
            'status': (context) => const StatusPage(),
          },
        ),
      ),
    );
  }
}
