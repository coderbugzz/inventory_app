/// product_form.dart
import 'package:flutter/material.dart';
import 'package:inventory_app/core/entities/product.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({
    super.key,
    required this.product,
    required this.onSubmit,
  });

  final Product product;
  final Function(Product product) onSubmit;

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void onSubmit() {
    widget.onSubmit(
      Product(
        // retain product id
        id: widget.product.id,
        name: _nameController.text,
        brandName: _brandNameController.text,
        category: _categoryController.text,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        price: double.tryParse(_priceController.text) ?? 0,
      ),
    );
  }

  @override
  void initState() {
    _nameController.text = widget.product.name;
    _brandNameController.text = widget.product.brandName;
    _categoryController.text = widget.product.category;
    _quantityController.text = widget.product.quantity.toString();
    _priceController.text = widget.product.price.toString();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandNameController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    _priceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Row(
            children: [
              const Expanded(child: Text('Product Name')),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText:
                        'Skechers Slip-ins: Glide-Step Swift - New Thrill',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Brand Name')),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _brandNameController,
                  decoration: const InputDecoration(
                    hintText: 'Skechers',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Category')),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    hintText: 'Sneakers',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Quantity')),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                      hintText: '1',
                      hintStyle: TextStyle(
                        color: Colors.black38,
                      )),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(child: Text('Price (USD)')),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: '1.00',
                    hintStyle: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onSubmit,
                  child: const Text('SUBMIT'),
                )),
          ),
        ],
      ),
    );
  }
}
