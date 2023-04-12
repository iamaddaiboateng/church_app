class BibleStudyModel {
  String name, leader, leaderContact, numMembers;

  BibleStudyModel({
    required this.name,
    required this.leader,
    required this.leaderContact,
    required this.numMembers,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();

    map['name'] = this.name;
    map['leader'] = this.leader;
    map['leaderContact'] = this.leaderContact;
    map['numMembers'] = this.numMembers;

    return map;
  }

  BibleStudyModel.fromMap(Map<dynamic, dynamic> map)
      : this.name = map['name'],
        this.leader = map['leader'],
        this.leaderContact = map['leaderContact'],
        this.numMembers = map['numMembers'];

  addHomeCell() {}
}
