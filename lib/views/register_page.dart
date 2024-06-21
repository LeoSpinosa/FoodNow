import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodnow2/services/firebase_connect.dart';
import 'package:foodnow2/views/login_page.dart';

import '../components/my_input.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repeatPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'FoodNow',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.green[800]),
              ),
              SizedBox(height: 40),
              MyInput(
                controller: nameController,
                placeholder: 'Nome',
                type: false,
                enabled: true,
              ),
              MyInput(
                controller: emailController,
                placeholder: 'Email',
                type: false,
                enabled: true,
              ),
              MyInput(
                controller: phoneController,
                placeholder: 'Telefone',
                type: false,
                enabled: true,
              ),
              MyInput(
                controller: passwordController,
                placeholder: 'Senha',
                type: true,
                enabled: true,
              ),
              MyInput(
                controller: repeatPasswordController,
                placeholder: 'Repita sua senha',
                type: true,
                enabled: true,
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Ja possui conta? ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Entre',
                      style: TextStyle(color: Colors.green[800], decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  register(nameController.text, phoneController.text, emailController.text, passwordController.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Registrar', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}