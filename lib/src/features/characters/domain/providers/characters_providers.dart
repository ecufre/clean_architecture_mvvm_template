import 'package:clean_architecture_mvvm_template/src/core/lib_core.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/bloc/characters_bloc.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/domain/repositories/characters_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_providers.g.dart';

@riverpod
CharactersRepository charactersRepository(Ref ref) =>
    CharactersRepositoryImpl(apiClient: ref.read(apiClientProvider));

@riverpod
CharactersBloc charactersBloc(Ref ref) =>
    CharactersBloc(repository: ref.read(charactersRepositoryProvider));
