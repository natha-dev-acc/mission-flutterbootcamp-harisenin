import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/trip_model.dart';

class TripRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> _tripCollection() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User belum login');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('trips');
  }

  Stream<List<TripModel>> getTrips() {
    return _tripCollection()
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TripModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> addTrip(TripModel trip) async {
    final doc = _tripCollection().doc();

    await doc.set(
      TripModel.fromEntity(trip).copyWith(id: doc.id).toMap(),
    );
  }

  Future<void> updateTrip(TripModel trip) async {
    if (trip.id.isEmpty) {
      throw Exception('ID tidak valid');
    }

    await _tripCollection().doc(trip.id).update(trip.toMap());
  }

  Future<void> deleteTrip(String id) async {
    await _tripCollection().doc(id).delete();
  }
}