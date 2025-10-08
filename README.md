<h1 align="center"> Code4Health </h1>

<p align="center">
  <img src="https://img.shields.io/badge/STATUS-EN%20DESARROLLO-blue">
</p>

<p align="center">
  Un asistente de compras inteligente diseñado para ayudarte a tomar decisiones más saludables en el supermercado.
</p>

---

## 📝 Descripción

**Code4Health** es una aplicación móvil desarrollada en Flutter que funciona como un **Asistente de Compras Inteligente**. El objetivo principal de la app es combatir la crisis de obesidad y sobrepeso, permitiendo a los usuarios escanear códigos de barras de productos para obtener información nutricional detallada, advertencias, y alternativas más saludables, todo basado en sus objetivos de salud y perfil personal.

---

## ✨ Características

* 🔐 **Autenticación de Usuarios:** Registro e inicio de sesión seguros.
* 👤 **Perfil de Salud Personalizado:** Recopilación de datos del usuario (edad, peso, altura, condiciones) para ofrecer recomendaciones a medida.
* 📱 **Gestión de Perfil:** Visualización y edición de toda la información de salud del usuario.
* 📷 **Escáner de Código de Barras:** Usa la cámara del dispositivo para escanear productos en tiempo real.
* 📊 **Análisis de Productos:** Muestra información detallada del producto escaneado, indicando si se ajusta a las necesidades dietéticas del usuario.
* 📚 **Historial de Escaneos:** Guarda un registro de todos los productos consultados para referencia futura.
* 💡 **Sugerencias de Productos:** Muestra alternativas más saludables y productos similares.

---

## 📱 Pantallas

<table>
  <tr>
    <td align="center"><img src="docs/images/Inicio-sesion.jpg" width="200"><br><sub><b>Inicio de Sesión</b></sub></td>
    <td align="center"><img src="docs/images/crear-cuenta.jpg" width="200"><br><sub><b>Crear Cuenta</b></sub></td>
    <td align="center"><img src="docs/images/informacion-usuario.jpg" width="200"><br><sub><b>Setup de Perfil</b></sub></td>
  </tr>
  <tr>
    <td align="center"><img src="docs/images/escaner.jpg" width="200"><br><sub><b>Escáner</b></sub></td>
    <td align="center"><img src="docs/images/historial.png" width="200"><br><sub><b>Historial</b></sub></td>
    <td align="center"><img src="docs/images/detalles.png" width="200"><br><sub><b>Detalles de Producto</b></sub></td>
  </tr>
   <tr>
    <td align="center"><img src="docs/images/perfil.jpg" width="200"><br><sub><b>Perfil de Usuario</b></sub></td>
    <td align="center" colspan="2"><img src="docs/images/edit-profile.jpg" width="400"><br><sub><b>Editar Perfil</b></sub></td>
  </tr>
</table>

---

## 🛠️ Tecnologías Utilizadas

<p p align="left">
  <a href="https://developer.android.com/?hl=es-419" target="_blank" rel="noopener noreferrer">
    <img src="https://skillicons.dev/icons?i=androidstudio" />
  </a>
  <a href="https://dart.dev/" target="_blank" rel="noopener noreferrer">
    <img src="https://skillicons.dev/icons?i=dart" />
  </a>
  <a href="https://flutter.dev/" target="_blank" rel="noopener noreferrer">
    <img src="https://skillicons.dev/icons?i=flutter" />
  </a>
  <a href="https://firebase.google.com/" target="_blank" rel="noopener noreferrer">
    <img src="https://skillicons.dev/icons?i=firebase" />
  </a>
</p>

* **Framework:** [Flutter](https://flutter.dev/)
* **Lenguaje:** [Dart](https://dart.dev/)
* **Arquitectura:** en Capas
* **Escáner:** [mobile_scanner](https://pub.dev/packages/mobile_scanner)
* **APIs:** [Open Food Facts API](https://openfoodfacts.org/), [Firebase](https://firebase.google.com/)

---

## 📂 Estructura del Proyecto

El proyecto sigue los principios de **Clean Architecture** para separar las responsabilidades y facilitar la escalabilidad. El código está organizado por *features* (módulos), y cada uno contiene tres capas:

* **`presentation`**: Contiene los widgets (UI) y la lógica de estado.
* **`domain`**: El corazón de la aplicación. Contiene las entidades, los casos de uso y los contratos (repositorios abstractos). Es independiente de cualquier framework.
* **`data`**: Implementa los repositorios del dominio. Se encarga de obtener los datos de fuentes externas (APIs, bases de datos).

## 🚀 Empezando

Sigue estos pasos para ejecutar el proyecto en tu máquina local.

### **Prerrequisitos**

Asegúrate de tener el [SDK de Flutter](https://flutter.dev/docs/get-started/install) instalado en tu computadora.

### **Instalación**

1.  **Clona el repositorio:**
    ```sh
    git clone https://github.com/Daavid-Anaya/code4health.git
    ```
2.  **Navega al directorio del proyecto:**
    ```sh
    cd code4health
    ```
3.  **Instala las dependencias:**
    ```sh
    flutter pub get
    ```
4.  **Ejecuta la aplicación:**
    ```sh
    flutter run
    ```
    
---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles.
