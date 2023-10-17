/// main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_app/app.dart';
import 'package:inventory_app/core/repositories/product_repository.dart';
import 'package:inventory_app/core/use_cases/product_usecase.dart';
import 'package:inventory_app/data/repositories/product_repository_impl.dart';
import 'package:inventory_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Firebase based on generated firebase_options file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize dependencies/instances
  loadDependencies();

  runApp(const MyApp());
}

/// main.dart
GetIt locator = GetIt.instance;

void loadDependencies() {
  //
  final firestore = FirebaseFirestore.instance;

  locator.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(firestore));
  locator.registerLazySingleton<GetAllProductUseCase>(
      () => GetAllProductUseCase(locator<ProductRepository>()));
  locator.registerLazySingleton<GetByIdProductUseCase>(
      () => GetByIdProductUseCase(locator<ProductRepository>()));
  locator.registerLazySingleton<CreateProductUseCase>(
      () => CreateProductUseCase(locator<ProductRepository>()));
  locator.registerLazySingleton<UpdateProductUseCase>(
      () => UpdateProductUseCase(locator<ProductRepository>()));
  locator.registerLazySingleton<DeleteProductUseCase>(
      () => DeleteProductUseCase(locator<ProductRepository>()));
}
