import 'package:flutter/material.dart';
import 'package:flutter_future_provider_test/entity.dart';
import 'package:flutter_future_provider_test/view.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_future_provider_test/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'fake_repository.dart';

void main() {
  testWidgets('Testing view', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          repositoryProvider.overrideWithProvider(
            Provider((ref) => FakeRepository()),
          ),
        ],
        child: MaterialApp(
          home: View(),
        ),
      ),
    );
    // The first frame is a loading state.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // Re-render. listProvider should have finished fetching the list by now.
    await tester.pump();
    // Rendered one item with the data returned by FakeRepository.
    expect(tester.widgetList(find.byType(Entity)), [
      isA<Entity>()
          .having((Entity entity) => entity.id, 'id', 1)
          .having((Entity entity) => entity.title, 'title', 'First title'),
    ]);
    // No-longer loading
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
