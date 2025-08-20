import 'package:clean_architecture_mvvm_template/src/core/view_model/models/view_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:clean_architecture_mvvm_template/src/core/view_model/models/view_state.dart';

class BaseViewModel<T> extends StateNotifier<ViewState> {
  BaseViewModel() : super(const ViewState.initial());

  void setState(ViewState viewState) {
    state = viewState;
  }
}
