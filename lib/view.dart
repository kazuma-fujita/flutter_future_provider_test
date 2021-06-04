import 'package:flutter/material.dart';
import 'package:flutter_future_provider_test/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'entity.dart';

class View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final asyncValue = context.read(listProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider Test'),
      ),
      body: Center(
        child: asyncValue.when(
          data: (list) => list.isNotEmpty
              ? ListView(
                  children: list
                      .map(
                        (Entity entity) => Text(entity.title),
                      )
                      .toList(),
                )
              : const Text('List is empty.'),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(error.toString()),
        ),
      ),
    );
  }
}
