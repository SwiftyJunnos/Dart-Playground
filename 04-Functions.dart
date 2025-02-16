void main() async {
  functions();
}

void enableFlag(bool bold) {}

// Named parameter는 {} 안에서 사용
// Named parameter: 기본값 파라미터
// 기본값을 명시하지 않으면 Null로 설정됨 (bool?과 같이 타입 명시 필요)
// 명시하지 않고 Nullable로 사용하지 않으려면 required 사용
void enableFlags({bool bold = false, required bool hidden}) {
  print('bold: $bold, hidden: $hidden');
}

String say(String from, String msg, [String? device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = '$result with a $device';
  }
  return result;
}

Function makeAdder(int addBy) {
  return (int i) => addBy + i;
}

void functions() {
  enableFlags(bold: true, hidden: false);
  assert(say('John', 'Hello') == 'John says Hello');
  assert(say('John', 'Hello', 'phone') == 'John says Hello with a phone');

  // Anonymous functions
  List<String> list = ['a', 'b', 'c'];
  var uppercaseList = list.map((item) => item.toUpperCase()).toList();
  print(uppercaseList);

  // Lexical closure
  var add2 = makeAdder(2);
  print(add2(3));
}

void generators() async {
  // Generator
  // 1. Synchronous Generator
  // body를 sync*로 표시, yield로 값 생성
  Iterable<int> naturalsTo(int n) sync* {
    int k = 0;
    while (k < n) yield k++;
  }

  naturalsTo(5).forEach(print);

  // 2. Asynchronous Generator
  // async*로 표시, yield로 값 생성
  Stream<int> asyncNaturalsTo(int n) async* {
    int k = 0;
    while (k < n) yield k++;
  }

  await asyncNaturalsTo(5).forEach(print);
}
