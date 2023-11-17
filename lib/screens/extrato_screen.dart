import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:ringo/controller/generic_controller.dart';
import 'package:ringo/data/ringo_db_provider.dart';
import 'package:ringo/helpers/routes_helper.dart';
import 'package:ringo/helpers/text_helper.dart';
import '../model/generic_model.dart';
import '../widgets/back_add_button_widget.dart';

class ExtratoScreen extends StatefulWidget {
  const ExtratoScreen({super.key});

  @override
  State<ExtratoScreen> createState() => _ExtratoScreenState();
}

class _ExtratoScreenState extends State<ExtratoScreen> {
  final _formKey = GlobalKey<FormState>();
  final extratoController = GenericController(RingoDbProvider());
  final dateController = TextEditingController();
  final valueController = TextEditingController();
  bool isOn = false;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _initialize() async {
    await extratoController.readAll();
    setState(() {});
  }

  void _selectDate(BuildContext context) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    ).then((selectedDate) {
      if (selectedDate != null) {
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      }
    });
  }

  openDialog() => showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Nova Transação'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: dateController,
                          autofocus: true,
                          decoration: const InputDecoration(hintText: 'Data'),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          onSaved: (date) => extratoController.date = date),
                      TextFormField(
                        controller: valueController,
                        autofocus: true,            
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),

                        decoration: const InputDecoration(hintText: 'Valor'),
                        onSaved: (newValue) => extratoController.value =
                            double.tryParse(newValue!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => exit(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _onSave(context);
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      );

  void exit() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _initialize,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackAddButtonWidget(openDialog),
              const Text(
                TextHelper.extratoTitle,
                style: TextStyle(fontSize: 20),
              ),
              Flexible(
                child: ListView.builder(
                  itemCount: extratoController.length,
                  itemBuilder: (ctx, index) {
                    final data = extratoController.data[index];
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              extratoController.id = data.id;
                              dateController.text = data.date.toString();
                              valueController.text = data.value.toString();
                              openDialog();
                            },
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            icon: Icons.edit,
                            label: 'Update',
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {
                              _onDelete(data);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.black,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: null,
                        child: Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(data.date.toString()),
                            trailing: Text(data.value.toString()),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _onDelete(GenericModel model) {
    extratoController.delete(model);
    _initialize();
  }

  Future _onSave(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await extratoController.save();
      if (!mounted) return;
      Navigator.of(context).pop();
      _initialize();
    }
  }
}
