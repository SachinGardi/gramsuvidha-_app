import 'package:flutter/material.dart';

class ImageZoomPage extends StatefulWidget {
  final String imageUrl;
  const ImageZoomPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<ImageZoomPage> createState() => _ImageZoomPageState();
}

class _ImageZoomPageState extends State<ImageZoomPage> {

  final _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      _transformationController.value = Matrix4.identity()
    ..translate(-position.dx, -position.dy)
    ..scale(2.0);
      // // For a 3x zoom
      // _transformationController.value = Matrix4.identity()
      //   ..translate(-position.dx * 2, -position.dy * 2)
      //   ..scale(3.0);
      // Fox a 2x zoom

    }
  }
  @override
  Widget build(BuildContext context) {
    print(widget.imageUrl);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: 
        GestureDetector(
          onDoubleTapDown: (d) => _doubleTapDetails = d,
          onDoubleTap: _handleDoubleTap,
          child: Center(
            child: InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: true,
              minScale: 0.1,
              maxScale: 4,
              clipBehavior: Clip.none,
              child: Image.network(widget.imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
