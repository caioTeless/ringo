import 'package:flutter/material.dart';

import '../widgets/back_button_widget.dart';

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const BackButtonWidget(),
            Expanded(
              child: ListView(
                children: [
                  SwitchListTile(
                      title: const Text('Configuração 1'),
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          value = !value;
                        });
                      }),
                  SwitchListTile(
                      title: const Text('Configuração 1'),
                      value: true,
                      onChanged: (value) {
                        setState(() {
                          value = !value;
                        });
                      }),
                  SwitchListTile(
                      title: const Text('Configuração 1'),
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          value = !value;
                        });
                      }),
                  SwitchListTile(
                      title: const Text('Configuração 1'),
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          value = !value;
                        });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
