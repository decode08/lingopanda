import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:lingopanda/model/auth_provider.dart';
import 'package:lingopanda/model/comments_provider.dart';
import 'package:lingopanda/res/color.dart';
import 'package:lingopanda/utils/routes/route.dart';
import 'package:lingopanda/view/homepage.dart';
import 'package:lingopanda/view/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final remoteConfig = FirebaseRemoteConfig.instance;
  remoteConfig.setDefaults(const {"mask_email": true});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<AuthProviders>(create: (_) => AuthProviders()),
      ChangeNotifierProvider(
        create: (_) => CommentsProvider(),
      )
    ], child: const MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textSize = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins',
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            primaryColor: AppColors.appBarColor,
            scaffoldBackgroundColor: AppColors.bgColor,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: AppColors.appBarColor),
              backgroundColor: AppColors.bgColor,
            ),
            textTheme: TextTheme(
              labelMedium: TextStyle(
                  fontSize: textSize * .04,
                  color: AppColors.appBarColor,
                  fontWeight: FontWeight.bold),
              displayLarge: TextStyle(
                fontSize: textSize * 0.04,
                color: AppColors.headingColor,
                fontStyle: FontStyle.italic,
              ),
              displayMedium: TextStyle(
                fontSize: textSize * 0.04,
                color: AppColors.frontColor,
                fontWeight: FontWeight.bold,
              ),
              displaySmall: TextStyle(
                  fontSize: textSize * 0.04,
                  color: AppColors.textColor,
                  fontStyle: FontStyle.normal),
              labelSmall: TextStyle(
                  fontSize: textSize * 0.04,
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold),
            )),
        // initialRoute: RoutesName.login_screen,
        onGenerateRoute: Routes.generateRoute,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return LoginPage();
            }
          },
        ));
  }
}
