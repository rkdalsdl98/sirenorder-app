import 'package:equatable/equatable.dart';

abstract class CheckState extends Equatable {
  String text;
  CheckState(this.text);

  @override
  List<Object?> get props => [text];
}

class OneCheckState extends CheckState {
  bool state = false;
  OneCheckState(super.text);

  void setCheckState(bool newState) => state = newState;
}

class DoubleCheckState extends CheckState {
  Map<DoubleCheckOrder, bool> states = {
    DoubleCheckOrder.first: false,
    DoubleCheckOrder.second: false,
  };
  DoubleCheckState(super.text);
  void setAllCheckState(bool newState) =>
      states.updateAll((key, prev) => newState);
  void setCheckState(DoubleCheckOrder order, bool newState) =>
      states[order] = newState;
}

enum DoubleCheckOrder {
  first,
  second,
}
