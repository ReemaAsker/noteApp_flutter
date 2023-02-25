class NoteModel {
  late int id;
  late String title;
  late String desc;
  late String creationDate;
  late String color;

  NoteModel(String title, String desc, String creationDate, String color) {
    this.title = title;
    this.desc = desc;
    this.creationDate = creationDate;
    this.color = color;
  }

  void addId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'creationDate': creationDate,
      'color': color,
    };
  }

  static fromMap(Map map) {
    return List.generate(map.length, (i) {
      NoteModel nM;
      nM = NoteModel(map[i]['title'], map[i]['desc'], map[i]['creationDate'],
          map[i]['color']);
      nM.addId(map[i]['id']);
      return nM;
    });
  }
}
