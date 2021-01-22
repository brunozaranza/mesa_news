import 'package:flutter/material.dart';
import 'package:mesa_news/ui/page/auth/login_email_page.dart';
import 'package:mesa_news/ui/page/auth/login_page.dart';
import 'package:mesa_news/ui/page/auth/register_page.dart';
import 'package:mesa_news/ui/page/feed_new_page.dart';
import 'package:mesa_news/ui/page/feed_page.dart';

class MesaRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/auth':
        return MaterialPageRoute(builder: (_) => LoginEmailPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/feed':
        return MaterialPageRoute(builder: (_) => FeedPage());
      case '/feed/new':
        return MaterialPageRoute(builder: (_) => FeedNewPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}