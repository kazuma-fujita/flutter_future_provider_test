import 'package:flutter_future_provider_test/entity.dart';
import 'package:flutter_future_provider_test/repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class ViewModel extends StateNotifier<AsyncValue<List<Entity>>> {
  ViewModel(AsyncValue<List<Entity>> state) : super(state);
  Future<void> fetchList();
}

class ViewModelImpl extends StateNotifier<AsyncValue<List<Entity>>>
    implements ViewModel {
  ViewModelImpl({required this.repository}) : super(const AsyncData([]));

  final Repository repository;

  @override
  Future<void> fetchList() async {
    state = const AsyncLoading();
    try {
      final list = await repository.fetchList();
      state = AsyncData(list);
    } on Exception catch (error) {
      state = AsyncError(error);
    }
  }
}
