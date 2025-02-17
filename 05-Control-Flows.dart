void main() {
  loops();
}

class Candidate {
  String name;
  int yearExperience;

  Candidate(this.name, this.yearExperience);
}

void loops() {
  for (var i = 0; i < 10; i++) {
    print(i);
  }

  var candidate1 = Candidate("John Doe", 5);
  var candidate2 = Candidate("Jane Doe", 3);
  var candidate3 = Candidate('Elizabeth', 2);
  var candidates = [candidate1, candidate2, candidate3];

  var nums = [1, 2, 3];
  for (final num in nums) {
    print(num);
  }

  for (final Candidate(:name, :yearExperience) in candidates) {
    print('$name has $yearExperience years of experience');
  }

  candidates.forEach((candidate) {
    print('${candidate.name}');
  });

  candidates
      .where((c) => c.yearExperience >= 3)
      .forEach((c) => print('${c.name} - ${c.yearExperience}'));
}
