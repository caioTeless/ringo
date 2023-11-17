import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ringo/controller/generic_controller.dart';
import 'package:ringo/data/ringo_db_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../helpers/routes_helper.dart';
import '../widgets/card_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final model = GenericController(RingoDbProvider());
  double value = 0.0;
  bool loading = false;
  String? selectedValue;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  void initState() {
    super.initState();
    _updateTotalAmount();
  }

  Future<void> _updateTotalAmount() async {
    loading = true;
    final Database database = await RingoDbProvider.getDatabase();
    final double amount = await RingoDbProvider.getTotalAmount(database);
    setState(() {
      value = amount;
    });
    loading = false;
    final test = await RingoDbProvider.getTotalByDate(database);
  }

  @override
  Widget build(BuildContext context) {
    var carouselSize = MediaQuery.of(context).size.height * 0.10;
    var cardSize = MediaQuery.of(context).size.height * 0.3;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Data',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 40,
                          width: 140,
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                        )),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: cardSize,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RingoRoutes.extrato)
                          .then((x) => _updateTotalAmount());
                    },
                    child: Card(
                      elevation: 3,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (loading)
                              const CircularProgressIndicator()
                            else
                              Text(
                                'R\$$value',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.11,
                                    fontWeight: FontWeight.w100),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: carouselSize,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CardOptions('Preferências'),
                      CardOptions('Relatórios'),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Card(
                        child: Text('Gráfico 1'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Card(
                        child: Text('Gráfico 1'),
                      ),
                    ),
                  ],
                ),
                Text('TOP 3'),
                Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text('3'),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text('3'),
                  ),
                ),
                Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text('3'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
