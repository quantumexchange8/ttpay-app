import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:splash_view/source/presentation/presentation.dart';
import 'package:splash_view/source/source.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/app_layout.dart';

void main() {
  Future.delayed(const Duration(milliseconds: 200)).then((val) {
    runApp(const MyApp());
  }, onError: (error) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GetMaterialApp(
      locale: const Locale('en', 'UK'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorObservers: [ClearFocusOnPop()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: Colors.transparent,
            surfaceTint: Colors.transparent,
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashView(
          showStatusBar: true,
          duration: const Duration(seconds: 2),
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
          title: Padding(
            padding: EdgeInsets.only(top: height20),
            child: Text(
              'Welcome to TTPAY! 👋',
              style: textLg.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          done: Done(
              animationDuration: const Duration(milliseconds: 300),
              const AppLayout())),
    );
  }
}

class ClearFocusOnPop extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration.zero);
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }
}
