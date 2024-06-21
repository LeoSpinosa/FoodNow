import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodnow2/components/my_input.dart';
import 'package:foodnow2/services/firebase_connect.dart';
import 'package:foodnow2/views/home_page.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await initializeFirebase();
    var auth = FirebaseAuth.instance;
    var db = FirebaseFirestore.instance;

    var userDoc = await db.collection('Users').doc(auth.currentUser!.uid).get();
    var userData = userDoc.data();

    if (userData != null) {
      nameController.text = userData['name'];
      emailController.text = userData['email'];
      contactController.text = userData['telefone'];
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyInput(
                  controller: nameController,
                  placeholder: "Nome",
                  type: false,
                  enabled: true,
                ),
                MyInput(
                  controller: emailController,
                  placeholder: "Email",
                  type: false,
                  enabled: false,
                ),
                MyInput(
                  controller: contactController,
                  placeholder: "Contato",
                  type: false,
                  enabled: true,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await update(nameController.text, contactController.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                  child: Text('Atualizar'),
                ),
              ],
            ),
    );
  }
}
