import 'dart:math';

void main() {
  // variables();
  operators();
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

