import 'dart:math';
import 'dart:collection' deferred as collection show HashMap;

void main() {
  // variables();
  // operators();
  // metadata();
  libraries();
}

void variables() {
  // var name = 'Bob';
  // Object name = 'Bob';
  String name = 'Bob';
  print(name);

  // Nullable type
  // Swift의 Optional
  int? count;
  print(count?.abs() ?? 0);
  count = Random().nextInt(100);

  // 변수의 초기화
  // Nullable 변수는 기본값으로 null을 사용한다.
  // 그 외 변수는 기본값을 지정해주어야 한다. 단, 변수가 사용되기 전에만 되면 된다.
  bool shouldAdd;
  if (count.isEven) {
    shouldAdd = true;
  } else {
    shouldAdd = false;
  }
  print(shouldAdd);

  // Late 초기화
  // Swift의 lazy
  // Late 변수는 초기화 전에 사용할 수 없다.
  // Swift와 마찬가지로 초기화에 this(self)가 필요한 경우 유용하게 사용 가능
  late int lateCount;
  // print(lateCount); Error
  lateCount = Random().nextInt(100);
  print(lateCount);

  // final & const
  // final: 한 번만 초기화 가능
  // const: 컴파일 타임 상수 (내부적으로는 final 사용)
  final String final_name = 'Bob';
  // final_name = 'Steve'; Error
}

enum StrokeCap {
  round,
  square,
  butt;
}

class Paint {
  String color = "red";
  StrokeCap strokeCap = StrokeCap.square;
  double strokeWidth = 1.0;

  String toString() {
    return 'Paint(color: $color, strokeCap: $strokeCap, strokeWidth: $strokeWidth)';
  }
}

void operators() {
  // Swift와 다르거나 모르는 내용만 정리

  assert(5 ~/ 2 == 2); // ~/: 나누고, 정수 결과 반환

  var value = 2;
  int? null_value;
  null_value ??= value; // ??= null_value가 null일 경우에만 할당

  // Cascade notation
  // Swift의 method chaining과 유사
  var paint = Paint()
    ..color = "blue"
    ..strokeCap = StrokeCap.butt
    ..strokeWidth = 2.0;
  print(paint);

  // Spread operators
  var a = [1, 2, 3];
  var b = [4, 5, 6];
  var c = [...a, ...b];
  print(c);

  // Conditional subscript
  List<int>? fooList;
  print(fooList?[0]);
  fooList = [1, 2, 3];
  print(fooList?[0]);
}

class Television {
  /// Use [turnOn] to turn on the television instead.
  @Deprecated('Use turnOn() instead.')
  void activate() {}
  void turnOn() {
    print('Turn on');
  }
}

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}

@Todo('Bob', 'Implement this')
void doSomething() {
  print('Do something');
}

void metadata() {
  doSomething();
}

// Lazy loading library
// import 'dart:collection' deferred as collection show HashMap;

Future<void> libraries() async {
  // Load when lazy library is needed
  await collection.loadLibrary();
  var hashmap = collection.HashMap<String, int>();
  hashmap['k1'] = 1;
  print(hashmap);

  // 라이브러리를 deferred(lazy) loading 할 때 유의할 점
  // 1. 라이브러리의 상수(constant)는 import한 파일에서는 상수가 아니다.
  //    loadLibrary()를 호출하기 전까지는 값이 존재하지 않기 때문이다.
  //    따라서 const 값을 가져오더라도, 그 값은 실제로 const가 아니다.
  // 2. 라이브러리의 타입을 사용할 수 없다.
  //    이는 공유 인터페이스를 별도의 라이브러리로 분리하여 사용하는 것으로 해결할 수 있다.
  // 3. loadLibrary() 함수는 `deferred as namespace`를 사용할 때 Dart 언어 내부적으로 추가해주는 기능이다.
  //    loadLibrary() 함수는 `Future` 값을 반환한다.
}
