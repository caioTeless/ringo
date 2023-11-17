import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ringo/controller/generic_controller.dart';
import 'package:ringo/data/ringo_db_provider.dart';
import 'package:ringo/model/generic_model.dart';

class ExtratoItemWidget extends StatefulWidget {
  const ExtratoItemWidget({super.key});

  @override
  State<ExtratoItemWidget> createState() => _ExtratoItemWidgetState();
}

class _ExtratoItemWidgetState extends State<ExtratoItemWidget> {
  final _extrato = GenericController(RingoDbProvider());

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future _initialize() async {
    await _extrato.readAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_extrato.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Flexible(
        child: ListView.builder(
          itemCount: _extrato.length,
          itemBuilder: (ctx, index) {
            final data = _extrato.data[index];
            return Slidable(
              key: const ValueKey(0),
              endActionPane:const ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                      onPressed: null,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.black,
                      icon: Icons.delete,
                      label: 'Delete'),
                ],
              ),
              child: ListTile(
                title: Text(data.date.toString()),
                trailing: Text(data.value.toString()),
              ),
            );
          },
        ),
      );
    }
  }

  _onDelete(GenericModel model) async {
    await _extrato.delete(model);
  }
}
