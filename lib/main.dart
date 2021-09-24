import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revent/pages/splash_screen.dart';
import 'package:revent/services/auth_service.dart';

const String AppTitle = "revent";

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeData themeData = ThemeData();

  runApp(
    MaterialApp(
      title: AppTitle,
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          primary: Color.fromRGBO(31, 38, 49, 1.0),
          secondary: Color.fromRGBO(130, 81, 202, 1.0),
        ),
      ),
      home: App(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  Widget _currentPage = SplashScreen();

  Future<void> initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();

      await AuthService.init();

      FirebaseAuth.instance.userChanges().listen((User user) {
        setState(() {
          this._currentPage = user == null ? Container() : Container();
        });
      });

      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    this.initializeFlutterFire();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Scaffold(
        body: Center(
          child: Text("Firebase Error!"),
        ),
      );
    }

    if (!_initialized) {
      return SplashScreen();
    }

    return _currentPage;
  }
}
