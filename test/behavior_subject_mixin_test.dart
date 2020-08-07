import 'package:behavior_subject_mixin/behavior_subject_mixin.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:test/test.dart';

class NumberNotifier extends StateNotifier<int> with BehaviorSubjectMixin {
  NumberNotifier(int initialState) : super(initialState);
}

void main() {
  group('BehaviorSubjectMixin#stream', () {
    test(
      'emits StateNotifier\'s initialState to every subscriber',
      () async {
        final notifier = NumberNotifier(2);
        await expectLater(notifier.stream, emits(2));
        await expectLater(notifier.stream, emits(2));
        await expectLater(notifier.stream, emits(2));
      },
    );

    test(
      'emits most recently updated StateNotifier\'s state to every subscriber',
      () async {
        final notifier = NumberNotifier(0);
        notifier.state = 1;
        notifier.state = 2;
        notifier.state = 3;

        await expectLater(notifier.stream, emits(3));
        await expectLater(notifier.stream, emits(3));
        await expectLater(notifier.stream, emits(3));
      },
    );
    test(
      'emits most recently updated StateNotifier\'s state `null` '
      'to every subscriber',
      () async {
        final notifier = NumberNotifier(0);
        notifier.state = 1;
        notifier.state = 2;
        notifier.state = null;

        await expectLater(notifier.stream, emits(isNull));
        await expectLater(notifier.stream, emits(isNull));
        await expectLater(notifier.stream, emits(isNull));
      },
    );
  });
}
