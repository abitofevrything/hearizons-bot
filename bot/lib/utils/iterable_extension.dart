extension IterableX<T> on Iterable<T> {
  String joinLast(String separator, String end) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return '';

    final buffer = StringBuffer(iterator.current.toString());

    bool hasPrevious = false;
    late T previous;

    while (iterator.moveNext()) {
      if (hasPrevious) {
        buffer.write(separator);
        buffer.write(previous);
      }

      hasPrevious = true;
      previous = iterator.current;
    }

    if (hasPrevious) {
      buffer.write(end);
      buffer.write(previous);
    }

    return buffer.toString();
  }
}
