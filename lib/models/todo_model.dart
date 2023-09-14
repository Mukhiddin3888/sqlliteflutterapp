


class TodoModel {
  final int? id;
  final String title;
  final String subTitle;

  const TodoModel({
    this.id,
    required this.title,
    required this.subTitle,

  });


  Map<String, dynamic> toMap(){

    return {
      "id" : id,
      "title": title,
      "subTitle": subTitle
    };

  }

  @override
  String toString() {
    return 'TodoModel{ id: $id, title:": $title, subTitle: $subTitle}';


  }

}