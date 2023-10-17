/// product_repository.dart
/// Defines an interface for the ProductRepository
import 'package:inventory_app/core/entities/product.dart';

abstract class ProductRepository {
  // get all products
  Stream<List<Product>> getAll();

  // get a product by id
  Future<Product> getById(String id);

  // creates a new product
  Future<void> create(Product product);

  // updates product details
  Future<void> update(Product product);

  // delete the product
  Future<void> delete(String id);
}
