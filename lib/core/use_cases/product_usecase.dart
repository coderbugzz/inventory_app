/// product_usecase.dart
/// the ProductUseCase encapsulates the business logic
/// It operates on entities and interacts with repositories
import 'package:inventory_app/core/entities/product.dart';
import 'package:inventory_app/core/repositories/product_repository.dart';

class GetAllProductUseCase {
  final ProductRepository repository;

  GetAllProductUseCase(this.repository);

  Stream<List<Product>> execute() {
    return repository.getAll();
  }
}

class GetByIdProductUseCase {
  final ProductRepository repository;

  GetByIdProductUseCase(this.repository);

  Future<Product> execute(String id) async {
    return await repository.getById(id);
  }
}

class CreateProductUseCase {
  final ProductRepository repository;

  CreateProductUseCase(this.repository);

  Future<void> execute(Product product) async {
    await repository.create(product);
  }
}

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<void> execute(Product product) async {
    await repository.update(product);
  }
}

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<void> execute(String id) async {
    await repository.delete(id);
  }
}
