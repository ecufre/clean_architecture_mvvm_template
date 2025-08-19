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
    _fetchCharacters();
  }
  late final CharactersMapper _mapper;
  final Logger _logger = Logger('CharactersBloc');
  final CharactersRepository _repository;

  final _charactersReadyStreamController = StreamController<bool>.broadcast();

  List<CharacterModel>? _characters;
  bool _charactersReady = false;

  List<CharacterModel>? get characters => _characters;
  bool get charactersReady => _charactersReady;
  Stream<bool> get charactersReadyStream =>
      _charactersReadyStreamController.stream;

  @override
  void dispose() {
    _charactersReadyStreamController.close();
  }

  void _emitCharactersReady() {
    _charactersReadyStreamController.add(_charactersReady);
  }

  Future<void> _fetchCharacters() async {
    try {
      _charactersReady = true;
      final response = await _repository.fetchCharacters();
      _characters = _mapper.convertList<CharacterDto, CharacterModel>(response);
      _emitCharactersReady();
    } catch (error, stackTrace) {
      _logger.severe(
        'Error on CharactersBloc._fetchCharacters',
        error,
        stackTrace,
      );
    }
  }
}
