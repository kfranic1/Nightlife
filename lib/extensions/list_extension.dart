extension ListExtension<T> on List<T> {
  List<T> rearrange(int Function(T, T)? compare) {
    sort(compare);
    return this;
  }

  T? get firstOrNull => length == 0 ? null : first;
}
