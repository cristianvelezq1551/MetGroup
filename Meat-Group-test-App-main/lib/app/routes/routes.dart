import 'package:flutter/material.dart';

import '../../data/models/store_model.dart';
import '../../ui/screens/auth/auth_screen.dart';
import '../../ui/screens/details/details_screen.dart';
import '../../ui/screens/stores/stores_screen.dart';
import '../../ui/screens/login/login_screen.dart';
import '../../ui/screens/register/register_screen.dart';

///The routes of the application.
abstract class AppRoutes {
  ///The route to the initial screen.
  static const initialRoute = '/';

  ///The route to the login screen.
  static const login = '/login';

  ///The route to the register screen.
  static const register = '/register';

  ///The route to the home screen.
  static const store = '/store';

  ///The route to the details screen.
  static const details = '/details';

  //?Routes
  static final routes = <String, WidgetBuilder>{
    initialRoute: (context) => const AuthScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    store: (context) => const StoresScreen(),
    details: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      final store = args['store'] as StoreModel;
      final onCreate = args['onCreate'] as Function(ItemModel)?;
      final onDelete = args['onDelete'] as Function(ItemModel)?;
      final onUpdate = args['onUpdate'] as Function(ItemModel)?;

      return DetailsScreen(
          store: store,
          onCreate: onCreate,
          onDelete: onDelete,
          onUpdate: onUpdate);
    }
  };
}
