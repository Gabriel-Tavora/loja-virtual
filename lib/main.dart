import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lojavirtual/informations/users/cart_model.dart';
import 'package:lojavirtual/informations/users/user_type.dart';
import 'package:lojavirtual/view/pages/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => UserType(),
      ),
      ChangeNotifierProxyProvider<UserType, CartModel>(
        create: (context) => CartModel(
          context.read<UserType>(),
        ),
        update: (context, user, cart) {
          cart ??= CartModel(user);
          cart.updateUser(user);
          return cart;
        },
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
      title: "Flutter's Clothing",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 4, 125, 141),
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
