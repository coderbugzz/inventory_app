/// home_screen.dart
/// The main UI for the app
import 'package:flutter/material.dart';

import 'package:inventory_app/core/entities/product.dart';
import 'package:inventory_app/core/use_cases/product_usecase.dart';
import 'package:inventory_app/main.dart';
import 'package:inventory_app/presentation/widgets/add_product.dart';
import 'package:inventory_app/presentation/widgets/edit_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetAllProductUseCase getAllProductUseCase =
      locator<GetAllProductUseCase>();
  final DeleteProductUseCase _deleteProductUseCase =
      locator<DeleteProductUseCase>();

  void addProduct() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('ADD PRODUCT'),
            content: AddProduct(),
          );
        });
  }

  void editProduct(Product product) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('UPDATE PRODUCT'),
            content: EditProduct(
              product: product,
            ),
          );
        });
  }

  Future<void> deleteProduct(Product product) async {
    //
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('DELETE PRODUCT'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCEL')),
            FilledButton(
              onPressed: () async {
                await _deleteProductUseCase.execute(product.id!);

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('CONFIRM'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Inventory App'),
      ),
      body: StreamBuilder(
        stream: getAllProductUseCase.execute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          final products = snapshot.data!;

          if (products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      addProduct();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 48,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Click the + icon to add a new product',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  )
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Table(
                border:
                    TableBorder.all(borderRadius: BorderRadius.circular(8.0)),
                children: [
                  const TableRow(children: [
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Product Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Brand Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Price (USD)',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                    TableCell(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )),
                  ]),
                  ...products.map(
                    (Product product) {
                      return TableRow(
                        children: [
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.name),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.brandName),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.category),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.quantity.toString()),
                          )),
                          TableCell(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.price.toString()),
                          )),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => editProduct(product),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => deleteProduct(product),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
