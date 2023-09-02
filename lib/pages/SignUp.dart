import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//A simple SignUp Page
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //Business logic to implement SignUp
  Future<void> _signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Successful signup, navigate to the next screen or perform other actions.
      if (context.mounted) {
        Navigator.popAndPushNamed(context, "/home");
      }
    } catch (e) {
      // Handle signup errors, e.g., display an error message.
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
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
              onPressed: _signup,
              child: const Text('Sign Up'),
            ),

            ElevatedButton(
              onPressed: () {
                //Navigate to Login Page
                Navigator.of(context).popAndPushNamed("/login");
              },
              child: const Text('Already have Account? Login Here'),
            ),
          ],
        ),
      ),
    );
  }
}
