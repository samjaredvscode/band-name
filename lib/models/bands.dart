class Band {
  String id;
  String name;
  int votes;

  Band({
    required this.id,
    required this.name,
    required this.votes,
  });

  factory Band.fromMap(Map<String, dynamic> objectMap) {
    return Band(
      id: objectMap.containsKey('id') ? objectMap['id'] : 'no-id',
      name: objectMap.containsKey('name') ? objectMap['name'] : 'no-name',
      votes: objectMap.containsKey('votes') ? objectMap['votes'] : 0,
    );
  }
}
