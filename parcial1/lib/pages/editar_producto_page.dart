import 'package:flutter/material.dart';
import 'package:parcial1/models/product.dart';
import 'package:parcial1/repositories/product_repository.dart';

class EditarProductoPage extends StatefulWidget {
  final ProductRepository repository;
  final Product producto;

  const EditarProductoPage({
    super.key,
    required this.repository,
    required this.producto,
  });

  @override
  State<EditarProductoPage> createState() => _EditarProductoPageState();
}

class _EditarProductoPageState extends State<EditarProductoPage> {
  final tituloController = TextEditingController();
  final precioController = TextEditingController();
  final descripcionController = TextEditingController();
  String? categoriaSeleccionada;

  List<String> categorias = ['Electrónica', 'Ropa', 'Hogar'];

  @override
  void initState() {
    super.initState();
    tituloController.text = widget.producto.title;
    precioController.text = widget.producto.price.toString();
    descripcionController.text = widget.producto.description;
    categoriaSeleccionada = widget.producto.category;

    if (!categorias.contains(categoriaSeleccionada)) {
      categorias.add(categoriaSeleccionada!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Producto')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Editar el producto con id: ${widget.producto.id}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: tituloController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: precioController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descripcionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      prefixIcon: Icon(Icons.description),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    initialValue: categoriaSeleccionada,
                    hint: const Text('Seleccionar categoría'),
                    items: categorias.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => categoriaSeleccionada = value),
                    decoration: const InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      onPressed: _guardarProducto,
                      label: const Text('Guardar'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _guardarProducto() async {
    final titulo = tituloController.text.trim();
    final precio = double.tryParse(precioController.text.trim());
    final descripcion = descripcionController.text.trim();

    if (titulo.isEmpty || precio == null || descripcion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos')),
      );
      return;
    }

    categoriaSeleccionada ??= '';

    final nuevoProducto = Product(
      title: titulo,
      price: precio,
      description: descripcion,
      category: categoriaSeleccionada!,
      thumbnail: widget.producto.thumbnail,
      rating: widget.producto.rating,
    );

    try {
      final idProd = await widget.repository.putProducto(
        widget.producto.id!,
        nuevoProducto,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Producto actualizado correctamente con el id: $idProd',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Error al actualizar producto'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
