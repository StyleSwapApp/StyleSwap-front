import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  ConfirmationPopup({required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirmation"),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text("Confirmer"),
        ),
      ],
    );
  }
}