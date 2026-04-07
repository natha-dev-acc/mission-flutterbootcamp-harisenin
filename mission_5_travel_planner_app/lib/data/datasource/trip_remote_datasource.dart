import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/trip_model.dart';

class TripRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= COLLECTION PATH =================
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

  // ================= GET (REALTIME) =================
  Stream<List<TripModel>> getTrips() {
    try {
      return _tripCollection()
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return TripModel.fromMap(doc.id, doc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception('Gagal mengambil data trip: $e');
    }
  }

  // ================= ADD =================
  Future<void> addTrip(TripModel trip) async {
    try {
      final doc = _tripCollection().doc();

      await doc.set(
        trip.copyWith(id: doc.id).toMap(),
      );
    } catch (e) {
      throw Exception('Gagal menambah trip: $e');
    }
  }

  // ================= UPDATE =================
  Future<void> updateTrip(TripModel trip) async {
    try {
      if (trip.id.isEmpty) {
        throw Exception('ID tidak valid');
      }

      await _tripCollection().doc(trip.id).update(trip.toMap());
    } catch (e) {
      throw Exception('Gagal update trip: $e');
    }
  }

  // ================= DELETE =================
  Future<void> deleteTrip(String id) async {
    try {
      await _tripCollection().doc(id).delete();
    } catch (e) {
      throw Exception('Gagal hapus trip: $e');
    }
  }
}