import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:laza/core/constants/app_strings.dart';
import 'package:laza/data/models/cart_item.dart';
import 'package:laza/data/repositories/cart_repository.dart';
import 'package:laza/data/repositories/home_repository.dart';
import 'package:laza/logic/blocs/cart/cart_bloc.dart';
import 'package:laza/logic/blocs/home/home_bloc.dart';
import 'package:laza/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(cartRepository: CartRepository()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(homeRepository: HomeRepository()),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.home,
        routes: AppRoutes.getRoutes(),
      ),
    );
  }
}
