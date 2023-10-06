
class Pacient{
  final String id;
  final String name;
  final int age;
  final String sex;
  final String link_sheets;
  bool hasInserted;
  // final String religiao;
  // final String estado_civil;
  // final String residencia;
  // final String naturalidade;

  Pacient({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.link_sheets,
    required this.hasInserted
  });

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "name": name,
      "age": age,
      "sex": sex,
      "link_sheets": link_sheets,
      "hasInserted": hasInserted};
    }
}