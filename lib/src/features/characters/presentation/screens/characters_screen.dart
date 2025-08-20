import 'package:clean_architecture_mvvm_template/src/core/mixins/app_localizations_mixin.dart';
import 'package:clean_architecture_mvvm_template/src/core/view_model/models/view_state.dart';
import 'package:clean_architecture_mvvm_template/src/features/characters/presentation/view_models/characters_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersScreen extends ConsumerStatefulWidget {
  const CharactersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CharactersScreenState();
}

class _CharactersScreenState extends ConsumerState<CharactersScreen>
    with AppLocalizationsMixin {
  late final CharactersViewModel? _viewModel;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel = ref.read(charactersViewModelProvider.notifier);
      _viewModel?.getCharacters();
    });
  }

  Widget _buildBody(ViewState state) {
    return state.when(
      completed: (_) => _buildCharactersList(),
      error: (error) => _buildError(error),
      initial: _buildLoader,
      loading: _buildLoader,
    );
  }

  Widget _buildCharactersList() {
    return ListView.separated(
      separatorBuilder: (_, __) => const Divider(),
      itemCount: _viewModel?.charactersList.length ?? 0,
      itemBuilder: (context, index) {
        final character = _viewModel?.charactersList[index];
        return ListTile(
          title: Text(character!.name),
          subtitle: Text(character.status),
        );
      },
    );
  }

  Widget _buildError(String? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 80,
          ),
          const SizedBox(height: 20),
          const Text(
            'Something went wrong!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            error ?? '',
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(charactersViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: _buildBody(state),
    );
  }
}
