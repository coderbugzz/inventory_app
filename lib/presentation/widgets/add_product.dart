/// add_product.dart
import 'package:flutter/material.dart';
import 'package:inventory_app/core/entities/product.dart';
import 'package:inventory_app/core/use_cases/product_usecase.dart';
import 'package:inventory_app/main.dart';
import 'package:inventory_app/presentation/widgets/product_form.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final CreateProductUseCase _createProductUseCase =
      locator<CreateProductUseCase>();

  Future<void> onSubmit(Product product) async {
    await _createProductUseCase.execute(product);

    if (mounted) {
      Navigator.of(context).pop();
      // .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProductForm(
      product: const Product(
        name: '',
        brandName: '',
        category: '',
        quantity: 0,
        price: 0,
      ),
      onSubmit: (Product product) {
        onSubmit(product);
      },
    );
  }
}
