import 'package:flutter/material.dart';

class BackAddButtonWidget extends StatelessWidget {

  final Function()? onPressed;
  const BackAddButtonWidget(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        TextButton(
          onPressed: onPressed!,
          child: const Text('Nova Transação'),
        ),
      ],
    );
  }
}
