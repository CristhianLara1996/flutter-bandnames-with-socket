class Band {
  Band({required this.id, required this.name, this.votes = 0});
  final String id;
  final String name;
  final int votes;

  factory Band.fromMap(Map<String, dynamic> map) => Band(
      id: map['id'] ?? '', name: map['name'] ?? '', votes: map['votes'] ?? '');
}
