import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:parcial1/models/product.dart';

class ProductRepository {
  final Dio _dio;
  final urlApi = "https://dummyjson.com/products";

  bool primerIntento = true;
  bool primerIntentoCrear = true;

  ProductRepository(this._dio);

  Future<List<Product>> getListaProductos() async {
    try {
      final response = await _dio.get(urlApi);
      if (primerIntento) {
        primerIntento = false;
        throw Exception("Error simulado en el primer intento");
      }
      await Future.delayed(const Duration(seconds: 5));
      final List data = response.data['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error consultando la lista de productos: $e');
      rethrow;
    }
  }

  Future<Product> getProducto(int id) async {
    try {
      final response = await _dio.get("$urlApi/$id");
      return Product.fromJson(response.data);
    } catch (e) {
      debugPrint('Error consultando el producto con ID $id: $e');
      rethrow;
    }
  }

  Future<int> postProducto(Product producto) async {
    try {
      if (primerIntentoCrear) {
        primerIntentoCrear = false;
        throw Exception("Error simulado al crear el producto");
      }

      final response = await _dio.post("$urlApi/add", data: producto.toJson());
      return response.data['id'];
    } catch (e) {
      debugPrint('Error creando el producto: $e');
      rethrow;
    }
  }

  Future<int> putProducto(int id, Product producto) async {
    try {
      final response = await _dio.put("$urlApi/$id", data: producto.toJson());
      return response.data['id'];
    } catch (e) {
      debugPrint('Error actualizando el producto con id ${producto.id}: $e');
      rethrow;
    }
  }

  Future<void> deleteProducto(int id) async {
    try {
      await _dio.delete("$urlApi/$id");
    } catch (e) {
      debugPrint('Error eliminando el producto con id $id: $e');
      rethrow;
    }
  }
}
