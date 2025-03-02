import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<ui.Image> createLoadingPattern() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  
  final paint = Paint()
    ..color = Colors.grey.withOpacity(0.2)
    ..strokeWidth = 2.0;
  
  // Dibuixar línies diagonals
  for (double i = -100; i < 100; i += 10) {
    canvas.drawLine(
      Offset(i, 0), 
      Offset(i + 100, 100), 
      paint
    );
  }
  
  final picture = recorder.endRecording();
  return picture.toImage(100, 100);
}