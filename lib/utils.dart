import 'package:flutter/material.dart';

class Utils {
  static  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blueGrey[300];
      case 1:
        return Colors.orange[300];
      case 2:
        return Colors.red[300];
      case 3:
        return Colors.green[300];
      case 4:
        return Colors.brown[300];
    }
  }

  static String getImage(int index) {
    switch (index) {
      case 0:
        return "images/apostila1.webp";
      case 1:
        return "images/apostila2.webp";
      case 2:
        return "images/apostila3.webp";
      case 3:
        return "images/apostila4.webp";
      case 4:
        return "images/apostila5.webp";
    }
  }

  static String getTitle(int index) {
    switch (index) {
      case 0:
        return "Princípios Elementares";
      case 1:
        return "O Propósito Eterno";
      case 2:
        return "Vida em Cristo";
      case 3:
        return "Comunhão com Deus";
      case 4:
        return "Evangelho do Reino";
    }
  }

}