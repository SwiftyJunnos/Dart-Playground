void main() {
  // records();
  // collections();
  // generics();
  typedefs();
}

void records() {
  // Record: tuple과 유사한 형태의 데이터 구조
  var record = ('first', a: 2, b: true, 'last');
  print(record.b);

  (int, int) swap((int, int) record) {
    var (a, b) = record;
    return (b, a);
  }

  var num_record = swap((1, 2));
  print(num_record); // (2, 1)

  ({int a, bool b}) annotated_record;
  annotated_record = (a: 2, b: false);
  print(annotated_record);

  // 특이하게도 $1부터 시작한다.
  print(num_record.$1);
}

void collections() {
  // Sets
  Set<int> set = {1, 2, 3};
  print(set);
  set.add(4);
  print(set);
  set.addAll({3, 4, 5});
  print(set);

  // Maps: Dictionary
  Map<int, String> map = {1: 'one', 2: 'two'};
  print(map);

  // Spread
  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print(list2);

  List<int>? null_list;
  var list3 = [0, ...?null_list];
  print(list3);

  bool isPromoActive = false;
  List<String> furnitures = [
    'Oven',
    'Table',
    if (isPromoActive) 'Chair', // Collection if
    'Cabinet'
  ];
  print(furnitures);

  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  print(listOfStrings); // ['#0', '#1', '#2', '#3']
}

// Swift의 Generics와 유사 `extends` = `where`
abstract class Cache<T extends Comparable> {
  T getByKey(String key);
  void setByKey(String key, T value);
}

class StringCache extends Cache<String> {
  Map<String, String> storage = {};

  String getByKey(String key) {
    return 'value';
  }

  void setByKey(String key, String value) {
    storage[key] = value;
  }

  String toString() {
    return storage.toString();
  }
}

void generics() {
  var stringCache = StringCache();
  stringCache.setByKey('k1', 'Steve');
  print(stringCache);

  var nameSet = Set<String>.from(['John', 'Jane']);
  print(nameSet);
}

typedef IntList = List<int>;

void typedefs() {
  var intList = IntList.from([1, 2, 3]);
  print(intList);
}
