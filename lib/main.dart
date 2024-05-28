// ignore_for_file: use_build_context_synchronously

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/controller/auth_controller.dart';
// import 'package:go_router/go_router.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/controller/group_controller.dart';
import 'package:ttpay/controller/notification_controller.dart';
import 'package:ttpay/controller/token_controller.dart';
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

  Get.put(AuthController());
  Get.put(TokenController());
  Get.put(TransactionController());
  Get.put(GroupController());
  Get.put(UserController());
  Get.put(NotificationController());

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  Future.delayed(const Duration(milliseconds: 200)).then((val) {
    runApp(const MyApp());
  }, onError: (error) {});
}

// final routerConfig = GoRouter(initialLocation: '/initial', observers: [
//   ClearFocusOnPop()
// ], routes: [
//   GoRoute(
//     path: '/app_layout',
//     builder: (context, state) => const AppLayout(),
//   ),
//   GoRoute(
//     path: '/login',
//     builder: (context, state) => const LoginPage(),
//   ),
//   GoRoute(
//     path: '/initial',
//     builder: (context, state) => splashScreen(
//       key: state.pageKey,
//       asyncNavigationCallback: () async =>
//           await asyncNavigationCallback(context),
//     ),
//   )
// ]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GetMaterialApp(
      navigatorObservers: [ClearFocusOnPop()],
      initialRoute: '/initial',
      getPages: [
        GetPage(
          name: '/app_layout',
          page: () => const AppLayout(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/initial',
          page: () => splashScreen,
        )
      ],
      locale: const Locale('en', 'UK'),
      debugShowCheckedModeBanner: false,
      title: 'TTPAY',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: Colors.transparent,
            surfaceTint: Colors.transparent,
            seedColor: primaryPurpleScale),
        useMaterial3: true,
      ),
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

Widget splashScreen = FlutterSplashScreen.fadeIn(
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

Future<dynamic> asyncNavigationCallback() async {
  await Future.delayed(const Duration(milliseconds: 1500)).then((val) async {
    await tokenController.getToken();
    if (tokenController.token.isEmpty) {
      Get.offNamed('/login');
      return;
    }
    final getTransactionErrorText =
        await transactionController.getAllTransaction();
    if (getTransactionErrorText != null) {
      Get.offNamed('/login');
      return;
    }
    final getGroupsErrorText = await groupController.getAllGroup();
    if (getGroupsErrorText != null) {
      Get.offNamed('/login');
      return;
    }
    final getUserErrorText = await userController.getUser();
    if (getUserErrorText != null) {
      Get.offNamed('/login');
      return;
    }
    final getAccountListErrorText = await userController.getAllAccounts();
    if (getAccountListErrorText != null) {
      Get.offNamed('/login');
      return;
    }
    final getNotificationsErrorText =
        await notificationController.getAllNotifications();
    if (getNotificationsErrorText != null) {
      Get.offNamed('/login');
      return;
    }

    Get.offNamed('/app_layout');
    return;
  }, onError: (error) {
    Get.offNamed('/login');
    return;
  });
}
