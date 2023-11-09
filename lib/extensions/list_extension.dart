extension ListExtension<T> on List<T> {
  List<T> rearrange(int Function(T, T)? compare) {
    sort(compare);
    return this;
  }

  void move(T element, int index) {
    if (index < 0 || index >= length || !contains(element)) return;
    remove(element);
    insert(index, element);
  }

  T next(T element){
    int index = indexOf(element) + 1;
    if(index == length) index = 0;
    return this[index];
  }
  T previous(T element){
    int index = indexOf(element) - 1;
    if(index == -1) index += length;
    return this[index];
  }
}
