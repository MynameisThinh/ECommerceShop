import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_test/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:flutter_final_test/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_final_test/firebase_helper/firebase_options/firebase_options.dart';
import 'package:flutter_final_test/provider/app_provider.dart';
import 'package:flutter_final_test/screens/auth_ui/welcome/welcome.dart';
import 'package:flutter_final_test/widgets/theme.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOption,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AppProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, themeService, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        themeMode: themeService.isDarkModeOn ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        showSemanticsDebugger: false,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            } else {
              return const Welcome();
            }
          },
        ),
      );
    });
  }
}
