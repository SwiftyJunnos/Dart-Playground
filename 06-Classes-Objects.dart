void main() {
  // classes();
  // constructors();
  // abstracts();
  // enums();
  // extensions();
  // extensionTypes();
  callableObjects();
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

class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // getter - setter
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

// 추상화
abstract class Doer {
  void doSomething();
}

class A {
  // 존재하지 않는 변수나 메서드를 사용하려고 할 때 호출된다.
  // override하지 않으면 NoSuchMethodError 발생
  @override
  void noSuchMethod(Invocation invocation) {
    print(
      'You tried to use a non-existent member: '
      '${invocation.memberName}',
    );
  }
}

// Mixin
// 추상화 - Swift의 protocol과 유사
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertain();

  // Swift의 protocol과 달리 기본 구현도 가능
  // → Swift의 extension을 통한 기본 구현과 유사
  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

mixin Aggressive {
  bool canFight = true;
}

// 추상화
// 기본 구현이 불가능한 추상화 형태
abstract interface class Tuner {
  void tuneInstrument() {
    print("Hello");
  }
}

// on을 사용하면 mixin에서도 class를 상속받아 super로 부모 클래스에 접근 가능
mixin TunerMixin on Tuner {
  @override
  void tuneInstrument() {
    super.tuneInstrument();
  }
}

class Musician with Musical, Aggressive implements Tuner {
  @override
  void entertain() {
    if (canFight) {
      print("Fight");
    } else {
      print("Play");
    }
  }

  @override
  void tuneInstrument() {
    print('Tuning instrument');
  }

  Musician();
}

// mixin class는 mixin이지만, 클래스로도 사용 가능
mixin class Musician2 {}

void abstracts() {
  var musician = Musician();
  musician.canPlayPiano = true;
  musician.entertainMe();
  musician.entertain();

  musician.canFight = false;
  musician.entertain();
}

class ParentClass {
  void walk() {
    print('Walking');
  }
}

class ChildClass implements ParentClass {
  @override
  void walk() {
    print('Walking');
  }
}

class Child2Class extends ParentClass {
  @override
  void walk() {
    super.walk();
  }
}

/// mixin 예시

mixin ValidationMixin {
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-](2,4)$');

  bool validateEmail(String email) => _emailRegex.hasMatch(email);

  void showValidation() => print('Invalid Input!');
}

class UserForm with ValidationMixin {
  void submitForm(String email) {
    if (validateEmail(email)) {
      //
    } else {
      showValidation();
    }
  }
}

/// mixin class 예시

mixin class CacheManager {
  final Map<String, dynamic> _cache = {};

  void store(String key, dynamic value) => _cache[key] = value;

  dynamic retrieve(String key) => _cache[key];
}

class NetworkService extends CacheManager {
  Future<dynamic> fetchData(String key) async {
    final result = await retrieve(key);
    return result;
  }
}

class LocalDBStorage with CacheManager {
  Future<dynamic> fetchData(String key) async {
    final result = await retrieve(key);
    return result;
  }
}

/// abstract class 예시

abstract class DataRepository {
  Future<List<dynamic>> fetchAll();

  Future<void> delete(String id);

  void logOperation(String action) {
    print('${DateTime.now()}: $action performed');
  }
}

class APIRepository extends DataRepository {
  @override
  Future<List<dynamic>> fetchAll() async {
    // Implement fetchAll logic here
    return [];
  }

  @override
  Future<void> delete(String id) async {
    // Implement delete logic here
  }
}

/// interface class 예시

class Gateway {
  void process() {}
}

interface class PaymentGateway {
  void processPayment(double amount) {}
  void refundPayment(String transactionID) {}
}

class BankGateway extends PaymentGateway {}

void interfaceClasses() {
  var gateway = PaymentGateway();
}

// https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Y2RRXyRwfazdWDUpsPcmew.png
// 1. mixin
//   - Swift의 protocol과 유사
//   - 인스턴스화 불가능
//   - 채택하는 쪽에서는 with로 여러 개의 mixin 사용 가능
//   - abstract + 기본 구현
//   - 다른 mixin을 with로 채택하는 것은 불가능 (1-depth)
//
// 2. mixin class
//   - mixin으로 사용 가능한 클래스
//   - 클래스이지만 mixin처럼 with를 사용해 채택도 가능
//   - 클래스이기 때문에 메서드들은 body를 가지고 구현되어야 함
//   - 단독적으로 초기화되어 인스턴스로서 사용되지 못하는 클래스
//
// 3. abstract class
//   - 추상화
//   - 기본 구현이 불가능한 추상화 형태
//   - `extends`와 `implements` 모두 가능하다.
//   - 메서드는 body를 가지는 구현체일 수도 있고, 갖지 않는 추상체일 수도 있다.
//
// 4. interface class
//   - 추상화 클래스
//   - 모든 abstract 메서드들을 구현해야 한다.
//   - `implements` 만 될 수 있다. (`extends` 불가능)
//   - 메서드는 body를 가지는 구현체여야 한다.
//
// 5. abstract interface class
//   - 추상화 클래스
//   - `implements` 만 가능하다. (`extends` 불가능)
//   - 메서드는 body를 가지는 구현체일 수도 있고, 갖지 않는 추상체일 수도 있다.
//
// interface와 abstract
// interface
//   - implemented만 될 수 있음 (extended 될 수 없음)
//   - 메서드에 body를 제공할 수 있음
//   - 인스턴스화 될 수 있음
// abstract interface
//   - implemented만 될 수 있음 (extended 될 수 없음)
//   - 메서드에 body를 제공할 수 있음
//   - 인스턴스화 될 수 없음
// abstract
//   - extended, implemented 될 수 있음
//   - 메서드에 body를 제공할 수 있음
//   - 인스턴스화 될 수 없음

// 모든 enum은 `Enum` 클래스를 상속받는다.
// 이 때, `Enum` 클래스는 sealed class이다.
enum Color { red, green, blue }

// enum은 확장하여 일반적인 class처럼도 사용할 수 있다.
enum Vehicle implements Comparable<Vehicle> {
  car(tires: 4, passengers: 5, carbonPerKilometer: 400),
  bus(tires: 6, passengers: 50, carbonPerKilometer: 800),
  bicycle(tires: 2, passengers: 1, carbonPerKilometer: 0);

  // Generative Constructor는 `const`여야 한다.
  const Vehicle({
    required this.tires,
    required this.passengers,
    required this.carbonPerKilometer,
  });

  // Enum은 컴파일 타임에 모두 정의되어 있어야 한다. (dynamic instantiate 불가능)
  factory Vehicle.fromMap(Map<String, dynamic> map) {
    final int tires = map['tires'] as int;
    final int passengers = map['passengers'] as int;
    final int carbonPerKilometer = map['carbonPerKilometer'] as int;

    // 이미 정의되어 있는 values 중 일치하는 값 탐색
    return Vehicle.values.firstWhere(
      (vehicle) =>
          vehicle.tires == tires &&
          vehicle.passengers == passengers &&
          vehicle.carbonPerKilometer == carbonPerKilometer,
      orElse: () => throw ArgumentError('No matching vehicle found'),
    );
  }

  // 인스턴스 변수들은 final이어야 한다.
  final int tires;
  final int passengers;
  final int carbonPerKilometer;

  int get carbonFootprint => (carbonPerKilometer / passengers).round();

  bool get isTwoWheeled => this == Vehicle.bicycle;

  @override
  int compareTo(Vehicle other) => carbonPerKilometer - other.carbonPerKilometer;
}

void enums() {
  final favoriteColor = Color.blue;
  if (favoriteColor == Color.blue) {
    print('Your favorite color is blue!');
  }

  // Dart의 enum은 순서를 가진다. (values의 순서와 동일)
  assert(Color.blue.index == 2);

  for (final color in Color.values) {
    print(color.name);
  }
}

// 기존의 API에 extension으로 기능 추가 가능
// extension EXT_NAME on EXTENDING_TYPE
extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}

// Unnamed extension
// EXT_NAME은 생략 가능
extension on String {}

// Generic extension
extension MyFancyList<T> on List<T> {}

void extensions() {
  final stringNumber = '123';
  final number = stringNumber.parseInt();
  assert(number == 123);
}

// extension type
// 기존에 존재하는 타입에 extension으로 기능 추가
// e.g. int를 사용하는 ID 값에 값 변경을 막겠다면 아래와 같이 비교 연산자만 정의하여 사용할 수 있도록 제한 가능
//
// 이 때, 내부적으로 사용되는 '원래'의 타입은 representation 타입이라 부른다.
extension type IdNumber(int id) {
  operator <(IdNumber other) => id < other.id;
}

// implements를 통해
// 1. subtype과의 관계를 설명하거나
// 2. extension type에 representation 타입의 멤버를 사용할 수 있도록 인터페이스를 제공
// 할 수 있다.
//
// NumberI는 int의 모든 멤버 + body에 구현된 멤버를 사용할 수 있다.
extension type NumberI(int i) implements int {}

// representation 타입의 부모 타입의 멤버를 사용할 수 있다.
extension type Sequence<T>(List<T> _) implements Iterable<T> {}

// @redeclare를 통해 부모 클래스의 멤버를 재정의 가능
//
// @redeclare를 사용하려면 meta 패키지를 import 해야한다.
// import 'package:meta/meta.dart'
extension type MyString(String _) implements String {
  // @redeclare
  int operator [](int index) => codeUnitAt(index);
}

void extensionTypes() {
  var safeID = IdNumber(42424242);
  // safeID + 10; // Error: No '+' operator.
  // int myUnsafeID = safeID; // Error: Wrong type
  int myUnsafeID = safeID as int; // OK: representation 타입으로 캐스팅 가능
  assert(safeID < IdNumber(42424241)); // OK: 비교 연산자가 정의되어 있으므로 사용 가능
}

// Python의 __call__, Swift의 callAsFunction과 마찬가지로
// 클래스를 메서드와 같이 호출할 수 있도록 만들 수 있다.
class Upperer {
  String call(String input) => input.toUpperCase();
}

void callableObjects() {
  Upperer upper = Upperer();
  String result = upper('hello');
  assert(result == 'HELLO');
}
