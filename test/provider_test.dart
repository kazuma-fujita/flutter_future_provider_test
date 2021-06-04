import 'package:flutter_future_provider_test/entity.dart';
import 'package:flutter_future_provider_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'fake_repository.dart';

void main() {
  group('Testing future provider of riverpod.', () {
    test('Override repository provider.', () async {
      // Override the behavior of repositoryProvider to return
      // FakeRepository instead of Repository.
      final container = ProviderContainer(
        overrides: [
          repositoryProvider.overrideWithProvider(
            Provider((ref) => FakeRepository()),
          ),
        ],
      );

      // The first read if the loading state
      expect(
        container.read(listProvider),
        const AsyncValue<List<Entity>>.loading(),
      );

      /// Wait for the request to finish
      await Future<void>.value();

      expect(container.read(listProvider).data!.value, [
        isA<Entity>()
            .having((entity) => entity.id, 'id', 1)
            .having((entity) => entity.title, 'title', 'First title'),
      ]);
    });

    // Exposes the data fetched
    test('Override AsyncValue.data', () async {
      final container = ProviderContainer(
        overrides: [
          listProvider.overrideWithValue(
            const AsyncValue.data([
              Entity(id: 1, title: 'First title'),
              Entity(id: 2, title: 'Second title'),
              Entity(id: 3, title: 'Third title'),
            ]),
          )
        ],
      );

      expect(container.read(listProvider).data!.value, [
        isA<Entity>()
            .having((entity) => entity.id, 'id', 1)
            .having((entity) => entity.title, 'title', 'First title'),
        isA<Entity>()
            .having((entity) => entity.id, 'id', 2)
            .having((entity) => entity.title, 'title', 'Second title'),
        isA<Entity>()
            .having((entity) => entity.id, 'id', 3)
            .having((entity) => entity.title, 'title', 'Third title'),
      ]);
    });
  });
}
