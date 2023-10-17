/// product_repository_impl.dart
/// Holds the implementation of ProductRepository
/// Interacts with the data source
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_app/core/entities/product.dart';
import 'package:inventory_app/core/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepositoryImpl(this._firestore);

  @override
  Stream<List<Product>> getAll() {
    return _firestore.collection('products').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Product.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<Product> getById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firestore.collection('products').doc(id).get();
    return Product.fromJson(doc.data()!);
  }

  @override
  Future<void> create(Product product) async {
    DocumentReference<Map<String, dynamic>> docRef =
        _firestore.collection('products').doc();

    final id = docRef.id;

    product = product.copyWith(id: id);

    await docRef.set(product.toJson());
  }

  @override
  Future<void> update(Product product) async {
    await _firestore
        .collection('products')
        .doc(product.id!)
        .update(product.toJson());
  }

  @override
  Future<void> delete(String id) async {
    await _firestore.collection('products').doc(id).delete();
  }
}
