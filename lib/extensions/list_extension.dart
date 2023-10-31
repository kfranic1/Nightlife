extension ListExtension<T> on List<T> {
  List<T> rearrange(int Function(T, T)? compare) {
    sort(compare);
    return this;
  }

  T? get firstOrNull => isEmpty ? null : first;

  void move(T element, int index) {
    if (index < 0 || index >= length || !contains(element)) return;
    remove(element);
    insert(index, element);
  }
}
