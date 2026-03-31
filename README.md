# Flutter Parcial 1 - Tienda de Productos

**Autor:** Juan Diego Blandon Toro

Este es un proyecto de **Flutter** desarrollado para el parcial 1 de la clase de programación para dispositivos móviles en la universidad de caldas, en la carrera ingeniería en informática, que permite **listar, agregar, editar y eliminar productos** consumiendo una API de ejemplo.

> ⚠️ Nota: Originalmente se iba a usar [Fake Store API](https://fakestoreapi.com/), pero estaba caída, así que se utilizó [DummyJSON](https://dummyjson.com/) para la entrega y pruebas.

---

## Requisitos

- Flutter >= 3.0  
- Dart >= 3.0  
- Emulador o dispositivo físico (Android, iOS)  
- Conexión a Internet para consumir la API DummyJSON  

---

## Levantar el proyecto

1. **Clonar el repositorio:**

```bash
git clone https://github.com/JuandiToroJT/parcial1flutterJuanDiegoBlandon.git
cd parcial1flutterJuanDiegoBlandon/parcial1
```

2. **Instalar dependencias:**

```bash
flutter pub get
```

3. **Correr la app:**

```bash
flutter run
```

> La app puede ejecutarse en Android, iOS o Web.

---

## Funcionalidades

- 📋 **Listar productos:** Se muestran todos los productos obtenidos de la API.  
- 🔍 **Ver detalle de producto:** Permite ver información completa de un producto, incluyendo precio, categoría rating y descripción.  
- ➕ **Agregar producto:** Formulario para crear un nuevo producto.  
- ✏️ **Editar producto:** Permite actualizar la información de un producto existente, prellenando el formulario.  
- ❌ **Eliminar producto:** Muestra un diálogo de confirmación antes de eliminar.  

---

## Video de la app en funcionamiento

Incluido en el repositorio

> Muestra todas las funcionalidades: listar, agregar, editar y eliminar productos.

---

## Notas adicionales

- El proyecto utiliza un **`ProductRepository`** que maneja las llamadas a la API.  
- Se implementó **manejo de errores con diálogos y snackbars** para mejorar la experiencia del usuario.  
- Se aplicó **estilo moderno** con cards, padding y botones con íconos.  

---

## Autor

**Juan Diego Blandon Toro**  
Curso / Parcial: Parcial 1 – Programación en dispositivos móviles

