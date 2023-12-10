import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/firebase_options.dart';
import 'package:firstapp/views/login_view.dart';
import 'package:firstapp/views/register_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: "Home Page",
      theme: ThemeData(primarySwatch: Colors.lime),
      home: const HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.lime,
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // final user = FirebaseAuth.instance.currentUser;
                // if (user?.emailVerified ?? false) {
                // } else {
                //   return const VerifyEmailView();
                // }
                return const LoginView();
              default:
                return const Text("Loading..");
            }
          }),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(("Please verify your email.")),
      TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text("Send email verification"))
    ]);
  }
}
