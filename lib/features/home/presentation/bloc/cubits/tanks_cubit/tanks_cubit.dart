import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/entities/search_client.dart';
import '../../../../../../core/utils/app_strings.dart';

part 'tanks_state.dart';

class TanksCubit extends Cubit<TanksState> {
  TanksCubit() : super(TanksInitial());

  final Map<int, double> quantityFields = {};
  Map<String, dynamic>? selectedValue;
  SearchClient? client;
  String type = AppStrings.importer.toUpperCase();
  void changeType(String type) {
    emit(TanksChanged());
    this.type = type;
    selectedValue = null;
    emit(TanksInitial());
  }

  void saveClient(SearchClient client) {
    this.client = client;
  }

  void ChangeTank(Map<String, dynamic> tank) {
    emit(TanksChanged());
    selectedValue = tank;
    emit(TanksInitial());
  }

  void addQunatity(String value) {
    emit(TanksChanged());
    if (selectedValue != null) {
      quantityFields[selectedValue!['tankId']] = double.parse(value);
    }
    emit(TanksInitial());
  }

  void removeQunatity(String quantity) {
    emit(TanksChanged());
    if (quantityFields.containsKey(int.parse(quantity.toString()))) {
      quantityFields
          .removeWhere((key, value) => key == int.parse(quantity.toString()));
    }
    emit(TanksInitial());
  }

  void clear() {
    emit(TanksChanged());
    quantityFields.clear();
    selectedValue = null;
    client = null;
    emit(TanksInitial());
  }
}
