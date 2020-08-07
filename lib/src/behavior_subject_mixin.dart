import 'package:rxdart/rxdart.dart';
import 'package:state_notifier/state_notifier.dart';

/// A mixin which provides [stream] interface of [BehaviorSubject]
/// for [StateNotifier].
mixin BehaviorSubjectMixin<T> on StateNotifier<T> {
  BehaviorSubject<T> _subject;

  /// A stream which provides [state].
  Stream<T> get stream {
    _subject ??= BehaviorSubject.seeded(state);
    return _subject.stream;
  }

  @override
  set state(T value) {
    super.state = value;
    _subject?.add(value);
  }

  @override
  void dispose() {
    super.dispose();
    _subject?.drain<void>()?.then<dynamic>((_) => _subject.close());
  }
}