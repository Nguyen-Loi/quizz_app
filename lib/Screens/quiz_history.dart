import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizz/model/user_score.dart';

class QuizzHistory extends StatefulWidget {
  const QuizzHistory({super.key});

  @override
  State<QuizzHistory> createState() => _QuizzHistoryState();
}

class _QuizzHistoryState extends State<QuizzHistory> {
  Stream<List<UserScore>> getQuizHistory() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('user_scores')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return UserScore.fromMap(doc.data());
            }).toList());
  }

  void _showDetailsDialog(BuildContext context, UserScore userScore) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quiz ID: ${userScore.quizId}'),
              const SizedBox(height: 8),
              Text('Score: ${userScore.totalPoints}'),
              const SizedBox(height: 8),
              Text('Date: ${userScore.createdDate.toLocal()}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<UserScore>>(
        stream: getQuizHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No quiz history found.'));
          } else {
            final userScores = snapshot.data!;
            return ListView.builder(
              itemCount: userScores.length,
              itemBuilder: (context, index) {
                final userScore = userScores[index];
                return ListTile(
                  leading: const Icon(Icons.history, color: Colors.blue),
                  title: Text('Quiz ID: ${userScore.quizId}'),
                  subtitle: Text(
                      'Score: ${userScore.totalPoints} | Date: ${userScore.createdDate.toLocal()}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showDetailsDialog(
                        context, userScore); // Show dialog on tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
