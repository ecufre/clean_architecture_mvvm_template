import 'dart:async';
import 'package:clean_architecture_mvvm_template/src/core/lib_core.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/data/dtos/character_dto.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/mappers/characters_mapper.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/models/character_model.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/repositories/characters_repository.dart';
import 'package:logging/logging.dart';

class CharactersBloc extends BaseBloc {
  CharactersBloc({required CharactersRepository repository})
    : _repository = repository {
    _mapper = CharactersMapper();
  }
  late final CharactersMapper _mapper;
  final Logger _logger = Logger('CharactersBloc');
  final CharactersRepository _repository;

  Future<List<CharacterModel>> fetchCharacters() async {
    try {
      final response = await _repository.fetchCharacters();
      return _mapper.convertList<CharacterDto, CharacterModel>(response);
    } catch (error, stackTrace) {
      _logger.severe(
        'Error on CharactersBloc._fetchCharacters',
        error,
        stackTrace,
      );
      rethrow;
    }
  }
}
