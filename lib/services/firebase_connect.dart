import 'package:firebase_core/firebase_core.dart';
import 'package:foodnow2/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



// Inicialize o Firebase uma vez no início da aplicação
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

// Função de login
Future<bool> login(String email, String password) async {
  await initializeFirebase();
  try {
    // var auth = FirebaseAuth.instance;
    var auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
    print("Login bem-sucedido");
    return true;
  } catch (e) {
    print("Erro no login: $e");
    return false;
  }
}

// Função de registro
Future<bool> register(String name, String phone, String email, String password) async {
  await initializeFirebase();
  try {
    var auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(email: email, password: password);

    var db = FirebaseFirestore.instance;
    await db.collection('Users').doc(auth.currentUser!.uid).set({
      'nome': name,
      'email': email,
      'telefone': phone,
    });

    print("Cadastro realizado com sucesso");
    return true;
  } catch (e) {
    print("Erro ao cadastrar: $e");
    return false;
  }
}


Future<void> update(String name, String phone) async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Users').doc(auth.currentUser!.uid).set({
    'name': name,
    'email': auth.currentUser!.email,
    'telefone': phone,
  });
}


Future<void> sendFeedback(String message) async {
  await initializeFirebase();
  var db = FirebaseFirestore.instance;
  await db.collection('Feedback').doc('1').set({
    'messages': FieldValue.arrayUnion([message]),
  }, SetOptions(merge: true));
}


Future<List<QueryDocumentSnapshot>> getItens() async {
  await initializeFirebase();
  var db = FirebaseFirestore.instance;
  var itens = await db.collection('Itens').get();
  print(itens.docs);
  itens.docs.forEach((item) {
    print(item.data());
  });
  return itens.docs;
}