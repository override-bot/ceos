import 'package:ceos/core/services/authentication.dart';
import 'package:ceos/core/viewmodels/cart_viewmodel.dart';
import 'package:ceos/core/viewmodels/product_viewmodel.dart';
import 'package:ceos/core/viewmodels/user_viewmodel.dart';
import 'package:ceos/ui/widgets/onbaording_one.dart';
import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

AuthenticationService _authenticationService = AuthenticationService();
UserViewmodel _userViewmodel = UserViewmodel();
ProductViewmodel _productViewmodel = ProductViewmodel();
CartViewmodel _cartViewmodel = CartViewmodel();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return _authenticationService;
          }),
          ChangeNotifierProvider(create: (_) {
            return _userViewmodel;
          }),
          ChangeNotifierProvider(create: (_) {
            return _productViewmodel;
          }),
          ChangeNotifierProvider(create: (_) {
            return _cartViewmodel;
          })
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: OnboardingOne(),
        ));
  }
}
