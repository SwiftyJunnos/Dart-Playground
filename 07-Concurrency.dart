import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:http/http.dart' as http;

void main() async {
  futures();
}

// Dart의 모든 이벤트들은 Event Queue에 저장된다.
//
// Event Queue pseudo code
// while (eventQueue.waitForEvent()) {
//   eventQueue.processNextEvent();
// }
void concurrencies() {
  var url = Uri(host: 'https://example.com');
  http.get(url).then((response) {
    if (response.statusCode == 200) {
      print('Success');
    }
  });
}

// Futures
Future<String> _readFileAsync(String filename) {
  final file = File(filename);

  // readAsString() returns Future
  // then() registers a callback to be executed when `readAsString()` resolves.
  return file.readAsString().then((contents) {
    return contents.trim();
  });
}

Future<String> asyncAwaits(String filename) async {
  final file = File(filename);
  final contents = await file.readAsString();
  return contents.trim();
}

void futures() async {
  final fileData = await asyncAwaits('example.json');
  final jsonData = jsonDecode(fileData);

  print('Number of json keys: ${jsonData.length}');
}

// Streams
Stream<int> stream = Stream.periodic(const Duration(seconds: 1), (i) => i * i);

Stream<int> sumStream(Stream<int> stream) async* {
  var sum = 0;
  // await for: stream loop를 돌 때 사용
  await for (final value in stream) {
    yield sum += value;
  }
}

// Isolates
// Dart는 Swift의 Concurrency와 같이 Isolate를 사용하여 병렬 처리를 수행할 수 있다.
// Isolate는 독립적인 실행 단위로, 고유의 메모리를 가지며 단일 이벤트 루프를 사용해 처리된다.
//
// Isolate 안의 state는 기본적으로 다른 Isolate에서 접근할 수 없다.
// Isolate간의 통신은 오직 메시지 패싱으로만 가능하다.
//
// 모든 Dart 코드는 기본적으로 main Isolate에서 실행된다.
// 기본적으로 synchronous하게 실행되며, 버튼 이벤트⋅메서드 실행 등을 순차적으로 실행한다.
// 하지만 하나의 작업이 오랜 시간을 소요할 경우, 애니메이션 버벅임/화면 멈춤 등의 부작용이 일어날 수 있다.
// 이런 오랜 기간이 걸리는 작업들은 worker isolate에 분산시키는 것이 좋다. (worker isolation = background worker)
// worker isolate는 작업이 마무리되면 결과를 메시지로 전송한다.
//
// Isolate.run()을 사용해 단일 작업을 별도의 스레드에서 실행할 수 있다.
// Isolate.spawn()을 사용해 긴 수명의 Isolate을 생성할 수 있다.
int slowFib(int n) => n <= 1 ? 1 : slowFib(n - 1) + slowFib(n - 2);

void fib40() async {
  var result = await Isolate.run(() => slowFib(40));
  print('Fib(40) = $result');
}

// Isolate.spawn()은 같은 실행 코드를 공유하는 두 개의 Isolate를 만든다.
// 이 때, 이 두 개의 Isolate는 하나의 Isolate Group에 속해있다.
// Isolate Group에서는 코드를 공유하는 등의 최적화가 수행되며,
// Isolate.exit()은 Isolate가 같은 그룹에 속해있을 때만 호출할 수 있다.
//
// 완전히 다른 그룹의 Isolate를 만드려면 Isolate.spawnUri()를 사용한다.
// 이 때 실행 코드는 공유되는 것이 아니라 복사된다.
// 다른 그룹에 위치시켜야 하기 때문에 최적화가 진행되지 않으며, spawn()보다 느리다.
// 또한 Isolate 간 메시지 통신에도 더 많은 시간이 소요된다.

// Isolate는 스레드가 아니다.
// Isolate는 각자의 메모리를 가지며, 자신의 메모리에만 접근할 수 있다.
// (메시징 방식은 직접 접근이 아닌 해당 Isolate에 대한 요청)
//
// 메시지 타입
// 메시지는 SendPort를 통해 전송할 수 있으며, 몇몇 예외를 제외하고 모든 타입의 인스턴스를 전송할 수 있다.
// 예외: 고유의 리소스를 갖는 객체 (e.g. Socket), ReceivePort, DynamicLibrary, Finalizable, Finalizer,
//  NativeFinalizer, Pointer, UserTag, `@pragma('vm:isolate-unsendable')`로 마킹된 인스턴스

// Web에서의 Isolate
// Web 플랫폼에서는 Isolate를 사용할 수 없다 (😰...!)
// 대신 web workers를 사용할 수 있다.
// https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers
// 해당 방식은 스레드를 사용하며, Dart의 Isolate과는 많은 차이가 있다.
// 1. 스레드 간 데이터를 통신할 때, web workers는 데이터를 복사하여 전달한다.
// 2. web workers는 별도의 프로그램 진입점을 정의하고, 따로 컴파일하는 방법으로만 생성할 수 있다.
