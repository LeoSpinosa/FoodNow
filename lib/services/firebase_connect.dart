import 'package:firebase_core/firebase_core.dart';
import 'package:foodnow2/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';





// Inicialize o Firebase uma vez no início da aplicação
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<bool> login(String email, String password) async {
  await initializeFirebase();
  try {
    var auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
    print("Login bem-sucedido");
    return true;
  } catch (e) {
    print("Erro no login: $e");
    return false;
  }
}

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
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Feedback').doc(auth.currentUser!.uid).set({
    'messages': FieldValue.arrayUnion([message]),
  }, SetOptions(merge: true));
}

Future<List<String>> getFeedbacks() async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var doc = await db.collection('Feedback').doc(auth.currentUser!.uid).get();
  if (doc.exists && doc.data() != null) {
    List<dynamic> messages = doc.data()!['messages'];
    return List<String>.from(messages);
  }
  return [];
}

Future<void> addToFavorites(Map<String, String> foodItem) async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Favorites').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayUnion([foodItem]),
  }, SetOptions(merge: true));
}

Future<void> removeFromFavorites(Map<String, String> foodItem) async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Favorites').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayRemove([foodItem]),
  }, SetOptions(merge: true));
}

Future<List<Map<String, String>>> getFavorites() async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var doc = await db.collection('Favorites').doc(auth.currentUser!.uid).get();
  if (doc.exists && doc.data() != null) {
    List<dynamic> items = doc.data()!['items'];
    return List<Map<String, String>>.from(items.map((item) => Map<String, String>.from(item)));
  }
  return [];
}

Future<void> addCart(Map<String, String> foodItem) async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Cart').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayUnion([foodItem]),
  }, SetOptions(merge: true));
}

Future<void> removeCart(Map<String, String> foodItem) async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  await db.collection('Cart').doc(auth.currentUser!.uid).set({
    'items': FieldValue.arrayRemove([foodItem]),
  }, SetOptions(merge: true));
}

Future<List<Map<String, String>>> getCartItems() async {
  await initializeFirebase();
  var auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  var doc = await db.collection('Cart').doc(auth.currentUser!.uid).get();
  if (doc.exists && doc.data() != null) {
    List<dynamic> items = doc.data()!['items'];
    return List<Map<String, String>>.from(items.map((item) => Map<String, String>.from(item)));
  }
  return [];
}
