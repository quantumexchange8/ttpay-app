import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/controller/group_controller.dart';
import 'package:ttpay/controller/transaction_controller.dart';
import 'package:ttpay/controller/user_controller.dart';
import 'package:ttpay/helper/color_pallete.dart';
import 'package:ttpay/helper/dimensions.dart';
import 'package:ttpay/helper/text_style.dart';
import 'package:ttpay/pages/app_layout.dart';
import 'package:ttpay/pages/auth/login_page.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/font/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  Get.put(TransactionController());
  Get.put(GroupController());
  Get.put(UserController());

  Future.delayed(const Duration(milliseconds: 200)).then((val) {
    runApp(const MyApp());
  }, onError: (error) {});
}

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    Future<dynamic> asyncNavigationCallback() async {
      final getTransactionErrorText =
          await transactionController.getAllTransaction();
      if (getTransactionErrorText != null) {
        _navigatorKey.currentState?.pushReplacementNamed('login');
        return;
      }
      final getGroupsErrorText = await groupController.getAllGroup();
      if (getGroupsErrorText != null) {
        _navigatorKey.currentState?.pushReplacementNamed('login');
        return;
      }
      final getUserErrorText = await userController.getUser();
      if (getUserErrorText != null) {
        _navigatorKey.currentState?.pushReplacementNamed('login');
        return;
      }
      final getAccountListErrorText = await userController.getAllAccounts();
      if (getAccountListErrorText != null) {
        _navigatorKey.currentState?.pushReplacementNamed('login');
        return;
      }

      _navigatorKey.currentState?.pushReplacementNamed('app_layout');
      return;
    }

    return GetMaterialApp(
      navigatorKey: _navigatorKey,
      locale: const Locale('en', 'UK'),
      debugShowCheckedModeBanner: false,
      title: 'TTPAY',
      navigatorObservers: [ClearFocusOnPop()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: Colors.transparent,
            surfaceTint: Colors.transparent,
            seedColor: primaryPurpleScale),
        useMaterial3: true,
      ),
      home: splashScreen(
        asyncNavigationCallback: asyncNavigationCallback,
      ),
      routes: {
        'login': (context) => const LoginPage(),
        'app_layout': (context) => const AppLayout(),
      },
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

Widget splashScreen({Future<dynamic> Function()? asyncNavigationCallback}) {
  return FlutterSplashScreen.fadeIn(
      asyncNavigationCallback: asyncNavigationCallback,
      backgroundImage: Image.asset(
        'assets/images/Background.png',
        fit: BoxFit.fill,
      ),
      backgroundColor: Colors.black,
      childWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/login_icon_image/ttpay-logo.png',
            fit: BoxFit.fitHeight,
            height: height30 * 2,
          ),
          Padding(
            padding: EdgeInsets.only(top: height20),
            child: Text(
              'Welcome to TTPAY! 👋',
              style: textLg.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ));
}
