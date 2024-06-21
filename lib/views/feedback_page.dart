import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_input.dart';
import 'package:foodnow2/services/firebase_connect.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController texto = TextEditingController();
  List<String> feedbacks = [];

  @override
  void initState() {
    super.initState();
    _loadFeedbacks();
  }

  Future<void> _loadFeedbacks() async {
    var feedbacksFromFirestore = await getFeedbacks();
    setState(() {
      feedbacks = feedbacksFromFirestore;
    });
  }

  void _sendFeedback() async {
    if (texto.text.isNotEmpty) {
      await sendFeedback(texto.text);
      texto.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback enviado!')),
      );
      _loadFeedbacks(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          MyInput(
            placeholder: 'Feedback',
            type: false,
            controller: texto,
            enabled: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _sendFeedback,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text('Enviar'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      feedbacks[index],
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}