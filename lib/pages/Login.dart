import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//A simple Login Page
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Business logic to implement Login
  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Successful login, navigate to the next screen or perform other actions.
      if(context.mounted){
        Navigator.popAndPushNamed(context, "/home");
      }
    } catch (e) {
      //Handle Login Failed
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),

            ElevatedButton(
              onPressed: (){
                //Navigate to Sign Up Page
                Navigator.of(context).popAndPushNamed("/signup");
              },
              child: const Text('New User? Sign Up Here'),
            ),
          ],
        ),
      ),
    );
  }
}
