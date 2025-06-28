class Population {
  final String name;
  final int malePopulation;
  final int femalePopulation;
  final int totalPopulation;

  Population({
    required this.name,
    required this.malePopulation,
    required this.femalePopulation,
    required this.totalPopulation,
  });

  factory Population.fromJson(Map<String, dynamic> json) {
    return Population(
      name: json['name'] as String,
      malePopulation: json['malePopulation'] as int,
      femalePopulation: json['femalePopulation'] as int,
      totalPopulation: json['totalPopulation'] as int,
    );
  }
}
