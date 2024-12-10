import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberProviderManger {
  void addToProvider(int number, WidgetRef ref) {
    ref.read(numberProvider.notifier).state += number;
  }
}

final numberProvider = StateProvider<int>((ref) {
  return 0;
});
