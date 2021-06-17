extension DefaultMap<K, V> on Map<K, V> {
  V getOrElse(K key, V defaultValue) {
    if (this.containsKey(key)) {
      if (((this[key] == null) ||
          (defaultValue is String
              ? (this[key] != null && (this[key] as String).isEmpty)
              : false))) {
        return defaultValue;
      } else {
       return this[key];
      }
    } else {
      return defaultValue;
    }
  }
}


