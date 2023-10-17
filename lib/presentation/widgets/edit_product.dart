/// edit_product.dart
import 'package:flutter/material.dart';
import 'package:inventory_app/core/entities/product.dart';
import 'package:inventory_app/core/use_cases/product_usecase.dart';
import 'package:inventory_app/main.dart';
import 'package:inventory_app/presentation/widgets/product_form.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final UpdateProductUseCase _updateProductUseCase =
      locator<UpdateProductUseCase>();

  Future<void> _onSubmit(Product product) async {
    await _updateProductUseCase.execute(product);

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProductForm(
        product: widget.product,
        onSubmit: (Product product) {
          _onSubmit(product);
        });
  }
}
