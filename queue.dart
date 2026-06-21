class CustomQueue<T> {
  final List<T> _storage = [];

  void enqueue(T element) {
    _storage.add(element);
  }

  T? dequeue() {
    if (isEmpty) return null;
    return _storage.removeAt(0); 
  }

  T? peek() {
    if (isEmpty) return null;
    return _storage.first;
  }

  bool get isEmpty => _storage.isEmpty;
  int get length => _storage.length;
  List<T> toList() => List.unmodifiable(_storage);
}