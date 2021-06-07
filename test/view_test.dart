import 'package:flutter/material.dart';
import 'package:flutter_future_provider_test/entity.dart';
import 'package:flutter_future_provider_test/view.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_future_provider_test/main.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('Testing loading view.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          listProvider.overrideWithValue(
            const AsyncValue.loading(),
          ),
        ],
        child: MaterialApp(home: View()),
      ),
    );
    // The first frame is a loading state.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Testing empty list view.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          listProvider.overrideWithValue(
            const AsyncValue.data([]),
          ),
        ],
        child: MaterialApp(home: View()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('List is empty.'), findsOneWidget);
  });

  testWidgets('Testing list view.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          listProvider.overrideWithValue(
            const AsyncValue.data([
              Entity(id: 1, title: 'First title'),
            ]),
          ),
        ],
        child: MaterialApp(home: View()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('First title'), findsOneWidget);
  });

  testWidgets('Testing error view.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          listProvider.overrideWithValue(
            AsyncValue.error(Exception('Error message')),
          ),
        ],
        child: MaterialApp(home: View()),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Exception: Error message'), findsOneWidget);
  });
}
