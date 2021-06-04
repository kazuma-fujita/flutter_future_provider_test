import 'package:flutter/material.dart';
import 'package:flutter_future_provider_test/entity.dart';
import 'package:flutter_future_provider_test/repository.dart';
import 'package:flutter_future_provider_test/view.dart';
import 'package:flutter_future_provider_test/view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final repositoryProvider = Provider((ref) => Repository());

// ViewModel pattern
final viewModelProvider =
    StateNotifierProvider<ViewModel, AsyncValue<List<Entity>>>((ref) {
  return ViewModelImpl(repository: ref.read(repositoryProvider));
});

// FutureProvider pattern
final listProvider = FutureProvider<List<Entity>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return repository.fetchList();
});

void main() {
  runApp(
    ProviderScope(
      overrides: [
        listProvider.overrideWithValue(
          const AsyncValue.data([
            Entity(id: 1, title: 'First title'),
            Entity(id: 2, title: 'Second title'),
            Entity(id: 3, title: 'Third title'),
          ]),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Future Provider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: View(),
    );
  }
}
