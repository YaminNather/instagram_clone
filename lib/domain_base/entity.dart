abstract class Entity<T> {
  const Entity();

  @override  
  int get hashCode => getHashCode();

  @override
  bool operator==(final Object other) {
    if(other.runtimeType == runtimeType)
      return sameAs(other as T);

    return false;
  }

  bool sameAs(final T other);

  int getHashCode();
}