import 'package:flutter/material.dart';
import 'package:our_money/database/database.dart';
import 'package:our_money/pages/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var db = DataBase();

  Future initDB() async {
    await db.setDB();
  }

  @override
  void initState() {
    super.initState();
    initDB();
  }

  login() async {
    String username = usernameInput.text.toString();
    String password = passwordInput.text.toString();

    var res = await db.getLogin(username, password);

    print("Login Response: $res");

    if (res.isNotEmpty) {
      // Login successful, navigate to the home page.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      // Login failed, show an error message to the user.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username or Password is incorrect!'),
        ),
      );
    }
  }

  void _setLogin() {
    if (formKey.currentState!.validate()) {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Flexible(
            child: Form(
              key: formKey,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Image(
                        image: AssetImage('lib/assets/login.png'),
                        width: 200,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Our Money',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 232, 144, 248)),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      // Form Input
                      TextFormField(
                        controller: usernameInput,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username wajib diisi!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 232, 144, 248),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 232, 144, 248),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 144, 248),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 144, 248),
                            ),
                          ),
                          focusColor: Color.fromARGB(255, 232, 144, 248),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordInput,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 232, 144, 248),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 232, 144, 248),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 144, 248),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 232, 144, 248),
                            ),
                          ),
                          focusColor: Color.fromARGB(255, 232, 144, 248),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: _setLogin,
                        child: const Text('Login'),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 232, 144, 248),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          minimumSize: const Size.fromHeight(50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
