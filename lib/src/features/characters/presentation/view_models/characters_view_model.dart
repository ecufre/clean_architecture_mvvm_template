import 'package:clean_architecture_mvvm_template/src/core/view_model/base_view_model.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/bloc/characters_bloc.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/models/character_model.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/providers/characters_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final charactersViewModelProvider =
    StateNotifierProvider<CharactersViewModel, ViewState>((ref) {
      return CharactersViewModel(ref: ref);
    });

class CharactersViewModel extends BaseViewModel {
  CharactersViewModel({required Ref ref}) {
    _charactersBloc = ref.read(charactersBlocProvider);
  }

  late final CharactersBloc _charactersBloc;
  List<CharacterModel> _charactersList = [];

  List<CharacterModel> get charactersList => _charactersList;

  Future<void> getCharacters() async {
    try {
      setState(const ViewState.loading());
      _charactersList = await _charactersBloc.fetchCharacters();
      setState(const ViewState.completed());
    } catch (e) {
      setState(ViewState.error(errorMessage: e.toString()));
      rethrow;
    }
  }
}
