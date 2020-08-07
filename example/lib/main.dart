import 'dart:async';

import 'package:behavior_subject_mixin/behavior_subject_mixin.dart';
import 'package:state_notifier/state_notifier.dart';

class CounterNotifier extends StateNotifier<int> with BehaviorSubjectMixin {
  CounterNotifier() : super(0);

  void increment() => state++;
}

void main() {
  final counterNotifier = CounterNotifier();
  final subscription = counterNotifier.stream.listen((currentState) {
    print('count is $currentState.');
  });
  counterNotifier..increment()..increment()..increment();
  Timer.run(subscription.cancel);
}
