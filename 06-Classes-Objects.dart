import 'dart:math';

void main() {
  // classes();
  constructors();
}

class SomeClass {}

class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}

void classes() {
  // Constructor
  // var point = Point.fromJson({'x': 1, 'y': 2});

  // Constant Constructor
  // var point1 = const ImmutablePoint(2, 2);
  // var point2 = const ImmutablePoint(2, 2);
  // var point3 = ImmutablePoint(2, 2);
  // assert(point1 == point2); // True
  // assert(point1 == point3); // False

  // Object 타입 확인
  var a = SomeClass();
  print('Type of a is ${a.runtimeType}');
}

// Constructor
// 클래스 인스턴스를 생성하는 특수한 메서드 (생성자 + 팩토리..?)
// 클래스와 같은 네이밍을 갖는다.
// 1. Generative Constructor: 새로운 인스턴스를 생성, 인스턴스 변수들을 초기화
// 2. Default Constructor: Constructor를 생략하면 사용, Generative Constructor를 사용하지만 인자나 이름이 없음
// 3. Named Constructor: Constructor의 용도를 명시, 같은 인스턴스를 다양한 이름으로 생성 지원
// 4. Constant Constructor: 컴파일-타입 상수 인스턴스를 생성
// 5. Factory Constructor: 상속 하위 클래스를 생성하거나 캐싱된 인스턴스 로드
// 6. Redirecting Constructor: 다른 Constructor로 포워딩

const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  double x;
  double y;

  Point(this.x, this.y); // Generative Constructor
  Point.origin() // Named Constructor
      : x = xOrigin,
        y = yOrigin;
  Point.alongXAxis(double x) : this(x, 0); // Forwarding Constructor
  Point.fromJson(Map<String, double> json) // Initializer list
      : x = json['x']!, // 이 인스턴스 변수들은 body가 실행되기 전에 초기화된다. this 사용 불가능
        y = json['y']! {
    print('In Point.fromJson(): $x, $y'); // 인스턴스 변수 초기화 후에 실행
  }
  Point.withAssert(this.x, this.y) : assert(x >= 0) {
    print('In Point.withAssert(): ($x, $y)');
  }
}

class ImmutablePoint {
  final double x;
  final double y;

  const ImmutablePoint(this.x, this.y); // Constant Constructor
}

class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    // Factory Constructor
    // Factory Constructor에서는 this 접근 불가
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      print(msg);
    }
  }
}

void constructors() {
  var point1 = Point(1, 2);
  var point2 = Point.origin();
  var point3 = Point.alongXAxis(2);
  var immutablePoint = const ImmutablePoint(1, 2);

  var logger = Logger('UI');
  logger.log('Hello World!');

  var logMap = {'name': 'UI'};
  var loggerJson = Logger.fromJson(logMap);
  loggerJson.log('Hello World!');
  print(logger == loggerJson); // True
}

// Constructor는 자식 클래스에 상속되지 않는다.
// 대신 인자는 super를 통해 상속받은 클래스에서 사용할 수 있다.

// 상속 클래스에서 Constructor는 다음 순서대로 실행된다.
// 1. Initializer list
// 2. 부모 클래스의 무명(unnamed), 무인자(no-arg) Constructor
// 3. 클래스 본인의 무인자(no-arg) Constructor

class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}
