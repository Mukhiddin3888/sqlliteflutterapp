


class DogModel {
  final int id;
  final String name;
  final int age;

  const DogModel({
    required this.id,
    required this.name,
    required this.age,
  });


  Map<String, dynamic> toMap(){

    return {
      "id" : id,
      "name": name,
      "age": age
    };

  }

  @override
  String toString() {
    return 'Dog{ id: $id, name:": $name, age: $age}';


  }

}