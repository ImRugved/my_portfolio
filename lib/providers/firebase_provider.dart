import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseProvider {
  static final FirebaseProvider _instance = FirebaseProvider._internal();
  factory FirebaseProvider() => _instance;
  FirebaseProvider._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  FirebaseFirestore get firestore => _firestore;

  Future<void> submitContactForm({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      await _firestore.collection('contact_messages').add({
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'unread',
      });

      print('Contact form data submitted successfully!');
    } catch (e) {
      print('Error submitting contact form data: $e');
      throw Exception('Failed to submit contact form: $e');
    }
  }

  Future<void> resumeDownloadMessage({
    required String name,
    required String email,
  }) async {
    try {
      await _firestore.collection('resume_message').add({
        'name': name,
        'email': email,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'unread',
      });

      print('Contact form data submitted successfully!');
    } catch (e) {
      print('Error submitting contact form data: $e');
      throw Exception('Failed to submit contact form: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getContactMessages() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('contact_messages')
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();
    } catch (e) {
      print('Error getting contact messages: $e');
      return [];
    }
  }

  Future<void> updateMessageStatus(String messageId, String status) async {
    try {
      await _firestore.collection('contact_messages').doc(messageId).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating message status: $e');
      throw Exception('Failed to update message status: $e');
    }
  }

  Future<void> trackResumeDownload() async {
    try {
      // Reference to the resume_clicked collection and document
      final docRef = firestore.collection('resume_clicked').doc('counter');

      // Get the document
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Document exists, increment the counter
        await docRef.update({
          'count': FieldValue.increment(1),
          'last_clicked': FieldValue.serverTimestamp()
        });
      } else {
        // Document doesn't exist, create it with initial count
        await docRef.set({
          'count': 1,
          'first_clicked': FieldValue.serverTimestamp(),
          'last_clicked': FieldValue.serverTimestamp()
        });
      }

      print('Resume download tracked successfully!');
    } catch (e) {
      print('Error tracking resume download: $e');
      // Don't throw an exception here to prevent interrupting the download process
    }
  }

  Future<int> getResumeDownloadCount() async {
    try {
      // Reference to the resume_clicked collection and document
      final docRef = firestore.collection('resume_clicked').doc('counter');

      // Get the document
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Return the current count
        return (docSnapshot.data()?['count'] as num?)?.toInt() ?? 0;
      } else {
        return 0; // No downloads yet
      }
    } catch (e) {
      print('Error getting resume download count: $e');
      return 0; // Return 0 on error
    }
  }
}
