import 'package:hooks_riverpod/hooks_riverpod.dart';

final pageIndexNotifierProvider =
    StateNotifierProvider<PageIndexNotifier, int>((ref) {
  return PageIndexNotifier();
});

class PageIndexNotifier extends StateNotifier<int> {
  PageIndexNotifier() : super(0);

  void changeIndex(int index) {
    state = index;
  }
}
