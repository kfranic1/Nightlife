extension ListExtension<T> on List<T> {
  List<T> rearrange(int Function(T, T)? compare) {
    sort(compare);
    return this;
  }
}
