import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MiAppFedeloba());

class MiAppFedeloba extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorial Fedelobo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PaginaInicio(),
    );
  }
}

class PaginaInicio extends StatelessWidget {
  final List<String> imagenes = [
    'assets/gatito.jpg',
    'assets/gatito.jpg',
    'assets/gatito.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('¡Hola, soy Flutter!'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              print('Tocaste la campanita');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _crearCardConImagenYTexto(),
            _crearIconoYTexto(),
            _crearCarruselDeFotos(imagenes),
            _crearVideoLocal(),
            _crearBotonNavegar(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favoritos"),
        ],
      ),
    );
  }

  // CARD con imagen y texto
  Widget _crearCardConImagenYTexto() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Image.asset('assets/gatito.jpg', height: 200, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Este es un gatito bien fachero 🐱', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  // FILA con ícono y texto
  Widget _crearIconoYTexto() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.amber, size: 40),
          SizedBox(width: 10),
          Text('¡Este ícono brilla más que tu ex!', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // CARRUSEL de imágenes
  Widget _crearCarruselDeFotos(List<String> imagenes) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.8),
        itemCount: imagenes.length,
        itemBuilder: (context, index) {
          return _fotoCarrusel(imagenes[index]);
        },
      ),
    );
  }

  Widget _fotoCarrusel(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(url, fit: BoxFit.cover),
      ),
    );
  }

  // VIDEO local
  Widget _crearVideoLocal() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      child: VideoPlayerWidget(videoPath: 'assets/video.mp4'),
    );
  }

  // BOTÓN de navegación
  Widget _crearBotonNavegar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => PaginaDetalle()));
        },
        child: Text("Ir a otra página"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

// Página secundaria (detalle)
class PaginaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Detalle"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text("Aquí podrías mostrar más información o imágenes."),
      ),
    );
  }
}

// Widget personalizado para reproducir video
class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({required this.videoPath});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Reproducir automáticamente
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }
}
