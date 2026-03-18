class Participant {
  final String id;
  final String name;

  Participant({
    required this.id,
    required this.name,
  });

  Participant copyWith({String? id, String? name}) {
    return Participant(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}