import 'dart:async';

class SimpleBloc<T> {
  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  void add(T object) {
    if(!_controller.isClosed) {
      _controller.add(object);
    }
  }

  void addError(Object error) =>
      !_controller.isClosed;

  dispose() {
    if(!_controller.isClosed) {
      _controller.close();
    }
  }
}
