void main() {
  patterns();
}

void patterns() {
  // Matching
  var number = 2;
  switch (number) {
    case 1:
      print('One');
    case 2:
      print('Two');
    default:
      print('Unknown');
  }

  const a = 'a';
  const b = 'b';

  var obj = List<String>.from(['a', 'b']);
  switch (obj) {
    case [a, b]:
      print('$a, $b');
  }

  // Destructuring
  var numList = [1, 2, 3];
  var [one, two, three] = numList;
  print(one + two + three);

  switch (numList) {
    case [1 || 2, var z1, var z2]:
      print('$z1, $z2');
  }

  var isPrimary = switch (number) { 2 || 4 || 6 => true, _ => false };
  print(isPrimary);

  (int, int) pair = (1, 2);
  switch (pair) {
    case (int a, int b) when a > b:
      print('First element is greater');
    case (int _, int _):
      print('Second element is greater');
  }

  // JSON parsing 등의 상황에 유용
  const json = {
    'user': ['July', 25],
  };

  // 아래 두 가지 코드는 동일한 동작
  if (json is Map<String, Object?> &&
      json.length == 1 &&
      json.containsKey('user')) {
    var user = json['user'];
    if (user is List<Object> &&
        user.length == 2 &&
        user[0] is String &&
        user[1] is int) {
      var name = user[0] as String;
      var age = user[1] as int;
      print('User $name is $age years old.');
    }
  }

  if (json case {'user': [String name, int age]}) {
    print('User $name is $age years old.');
  }
}

// Dart pattern examples
// https://codelabs.developers.google.com/codelabs/dart-patterns-records
