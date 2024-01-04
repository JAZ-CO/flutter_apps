import 'package:flutter/material.dart';
import 'package:flutter_social_media/components/my_textfield.dart';
import 'package:flutter_social_media/components/mybutton.dart';
import 'package:flutter_social_media/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    // controllers
    final usernameController = TextEditingController();
    final paswordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),

              // welcome back
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome Back! you\'ve been missed!",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),

              // username textfield
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: usernameController,
                hintText: "Username",
                obsecureText: false,
              ),

              // password
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: paswordController,
                hintText: "Password",
                obsecureText: true,
              ),
              // forgot?
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Pawword?",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),

              // sign in button
              const SizedBox(
                height: 25,
              ),
              MyButton(
                onTap: () => signUserIn,
              ),

              // google + apple sign in
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "Or countinue with",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google
                  SquareTile(imagePath: 'lib/images/Google_.png'),

                  SizedBox(
                    width: 25,
                  ),
                  // apple
                  SquareTile(imagePath: 'lib/images/Apple_.png'),
                ],
              ),

              // not a member? register now
              const SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not a member?"),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Register Now",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
