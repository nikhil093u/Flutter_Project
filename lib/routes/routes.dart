import 'package:flutter/material.dart';
import 'package:flutter_application/features/auth/signin.dart';
import 'package:flutter_application/features/auth/signup.dart';
import 'package:flutter_application/features/customers/add_newcustomer.dart';
import 'package:flutter_application/features/customers/customers.dart';
import 'package:flutter_application/features/home/home.dart';
import 'package:flutter_application/features/orders/create_order.dart';
import 'package:flutter_application/features/orders/order_details.dart';
import 'package:flutter_application/features/orders/orders.dart';
import 'package:flutter_application/features/resources/resource.dart';
import 'package:flutter_application/features/resources/resource_details.dart';
import 'package:flutter_application/features/todo/task_details.dart';
import 'package:flutter_application/features/todo/todo.dart';
import 'package:flutter_application/landingpage.dart';

class Routes {
  static const home = '/home';
  static const customers = '/customers';
  static const orders = '/orders';
  static const todo = '/todo';
  static const resources = '/resources';
  static const landingpage = '/landingpage';
  static const signup = '/signup';
  static const signin = '/signin';
  static const addcustomer = '/addcustomer';
  static const createorder = '/create_order';
  static const orderdetails = '/orderdetails';
  static const resourcedetils = '/resourcedetils';
  static const taskdetails = '/taskdetails';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
      case landingpage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case addcustomer:
        return MaterialPageRoute(builder: (_) => AddCustomerForm());
      case createorder:
        return MaterialPageRoute(builder: (_) => CreateOrder());
      case orderdetails:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(builder: (_) => OrderDetails(order: args));
      case resourcedetils:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => ResourceDetails(
            title: args['title']??"",
            imagePath: args['imagePath']??"",
            description: args['description']??"",
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
