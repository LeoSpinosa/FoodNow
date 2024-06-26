import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:foodnow2/components/my_input.dart';
import 'package:foodnow2/services/firebase_connect.dart';
import 'package:foodnow2/views/home_page.dart';
import 'package:foodnow2/views/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    authenticate() async {
      var auth = await login(emailController.text, passwordController.text);
      if (auth == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuário ou senha incorretos.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Text(
                'FoodNow',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              SizedBox(height: 150),
              MyInput(
                controller: emailController,
                placeholder: 'Email',
                type: false,
                enabled: true
              ),
              MyInput(
                controller: passwordController,
                placeholder: 'Senha',
                type: true,
                enabled: true
              ),
              SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: 'Não possui conta? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Registre-se',
                      style: TextStyle(color: Colors.green[800], decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  authenticate();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Entrar', style: TextStyle(color: Colors.white)),
              ),
              Spacer(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}