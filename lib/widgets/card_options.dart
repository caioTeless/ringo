import 'package:flutter/material.dart';
import 'package:ringo/helpers/routes_helper.dart';

class CardOptions extends StatelessWidget {

  final String cardDescription;

  const CardOptions(this.cardDescription, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RingoRoutes.configuration);
          },
          child: Center(
            child: Text(cardDescription),
          ),
        ),
      ),
    );
  }
}
