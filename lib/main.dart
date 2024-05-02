import 'package:flutter/material.dart';
import 'package:splash_view/source/presentation/presentation.dart';
import 'package:splash_view/source/source.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashView(
          backgroundColor: Colors.black,
          backgroundImageDecoration: const BackgroundImageDecoration(
              image: AssetImage(
                'assets/images/Background.png',
              ),
              fit: BoxFit.fitHeight),
          logo: Image.asset(
            'assets/login_icon_image/ttpay-logo.png',
            fit: BoxFit.fitHeight,
            height: height30 * 2,
          ),
          title: Text(
            'Welcome to TTPAY! 👋',
            style: textLg.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          done: Done(const LoginPage())),
    );
  }
}
