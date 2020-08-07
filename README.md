# behavior_subject_mixin
A mixin which provides state of StateNotifier as a stream of BehaviorSubject.

# Usage

```dart
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
```

### Output
```
count is 0.
count is 1.
count is 2.
count is 3.
```