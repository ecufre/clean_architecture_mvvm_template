import 'package:clean_architecture_mvvm_template/src/features/characters/data/dtos/character_dto.dart';

abstract class CharactersRepository {
  Future<List<CharacterDto>> fetchCharacters();
}
