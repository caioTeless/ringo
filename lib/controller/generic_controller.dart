import 'package:ringo/data/ringo_db_provider.dart';
import 'package:ringo/model/generic_model.dart';

class GenericController {
  final RingoDbProvider _ringoDbProvider;
  int? id;
  String? date;
  double? value;
  int? type;
  double totalSum = 0.0;

  GenericController(this._ringoDbProvider);

  List<GenericModel> data = [];

  bool loading = false;

  int get length => data.isEmpty ? 0 : data.length;

  void setDate(String? date) => date = date;
  void setValue(double? value) => value = value;
  void setType(int? type) => type = type;

  Future save() async {
    final data = GenericModel(
      id: id,
      date: date,
      value: value,
      type: type,
    );
    if (id == null) {
      _ringoDbProvider.insert(data);
    } else {
      _ringoDbProvider.update(data);
    }
  }

  Future readAll() async {
    loading = true;
    data = await _ringoDbProvider.readAll();
    loading = false;
    return data;
  }

  Future delete(GenericModel model) async {
    loading = true;
    await _ringoDbProvider.delete(model);
    loading = false;
  }

  Future readById(int id) async {
    return _ringoDbProvider.readById(id);
  }

}
