import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/signin.dart';
import 'package:flutter_application/features/auth/signup.dart';
import 'package:flutter_application/features/customers/add_newcustomer.dart';
import 'package:flutter_application/features/customers/customers.dart';
import 'package:flutter_application/features/home/home.dart';
import 'package:flutter_application/features/orders/create_order.dart';
import 'package:flutter_application/features/orders/order_details.dart';
import 'package:flutter_application/features/orders/order_model.dart';
import 'package:flutter_application/features/orders/orders.dart';
import 'package:flutter_application/features/orders/repeatorder.dart';
import 'package:flutter_application/features/profile.dart';
import 'package:flutter_application/features/resources/resource.dart';
import 'package:flutter_application/features/resources/resource_details.dart';
import 'package:flutter_application/features/settings.dart';
import 'package:flutter_application/features/todo/task_details.dart';
import 'package:flutter_application/features/todo/todo.dart';
import 'package:flutter_application/landingpage.dart';

class Routes {
  static const root = '/';
  static const home = '/home';
  static const customers = '/customers';
  static const orders = '/orders';
  static const todo = '/todo';
  static const resources = '/resources';
  static const signup = '/signup';
  static const signin = '/signin';
  static const addcustomer = '/addcustomer';
  static const createorder = '/create_order';
  static const orderdetails = '/orderdetails';
  static const resourcedetails = '/resourcedetails';
  static const taskdetails = '/taskdetails';
  static const profile = '/ProfilePage';
  static const setting = '/SettingsPage';
  static const repeatorder = '/RepeatOrderPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LandingPage());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case customers:
        return MaterialPageRoute(builder: (_) => CustomerScreen());
      case orders:
        return MaterialPageRoute(builder: (_) => OrdersList());
      case todo:
        return MaterialPageRoute(builder: (_) => Todo());
      case resources:
        return MaterialPageRoute(builder: (_) => ResourcePage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case addcustomer:
        return MaterialPageRoute(builder: (_) => AddCustomerForm());
      case createorder:
        return MaterialPageRoute(builder: (_) => CreateOrder());
      case profile:
        return MaterialPageRoute(builder: (context) => const ProfilePage());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case repeatorder:
        return MaterialPageRoute(builder: (_) => RepeatOrderPage());
      case orderdetails:
        final args = settings.arguments as Order;
        return MaterialPageRoute(builder: (_) => OrderDetails(order: args));
      case resourcedetails:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => ResourceDetails(
            title: args['title'] ?? "",
            imagePath: args['imagePath'] ?? "",
            description: args['description'] ?? "",
          ),
        );
      case taskdetails:
        final args = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => TaskDetails(task: args));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
