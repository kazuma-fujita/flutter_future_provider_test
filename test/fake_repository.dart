import 'package:flutter_future_provider_test/entity.dart';
import 'package:flutter_future_provider_test/repository.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRepository implements Repository {
  @override
  Future<List<Entity>> fetchList() async {
    return [
      const Entity(id: 1, title: 'First title'),
    ];
  }
}
