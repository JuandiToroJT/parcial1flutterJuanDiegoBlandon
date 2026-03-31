import 'package:flutter/material.dart';
import 'package:parcial1/models/product.dart';
import 'package:parcial1/pages/agregar_producto_page.dart';
import 'package:parcial1/repositories/product_repository.dart';
import 'package:parcial1/widgets/product_item_widget.dart';

class HomePage extends StatefulWidget {
  final ProductRepository repository;

  const HomePage({super.key, required this.repository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> _productosFuture;
  bool mostrarAgregar = false;

  @override
  void initState() {
    super.initState();
    _consultarProductos();
  }

  void _consultarProductos() {
    setState(() {
      _productosFuture = widget.repository.getListaProductos();
    });

    _productosFuture
        .then((_) {
          setState(() {
            mostrarAgregar = true;
          });
        })
        .catchError((_) {
          setState(() {
            mostrarAgregar = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 157, 163, 216),
        title: const Text('Tienda de Productos'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error al cargar productos'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _consultarProductos,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final productos = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(30),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 25,
              mainAxisSpacing: 25,
              childAspectRatio: 0.7,
            ),
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final p = productos[index];
              return ProductItemWidget(
                product: p,
                repository: widget.repository,
              );
            },
          );
        },
      ),
      floatingActionButton: mostrarAgregar == true
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 9, 93, 99),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AgregarProductoPage(repository: widget.repository),
                  ),
                );
              },
              shape: CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
