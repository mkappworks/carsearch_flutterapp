import 'dart:convert';

Cars carsFromJson(String str) => Cars.fromJson(json.decode(str));

class Cars {
  final int count;
  final String message;
  final dynamic searchCriteria;
  final List<Car> cars;

  Cars(
      {required this.count,
      required this.message,
      required this.searchCriteria,
      required this.cars});

  factory Cars.fromJson(Map<String, dynamic> json) => Cars(
      count: json["Count"],
      message: json["Message"],
      searchCriteria: json["searchCriteria"],
      cars: List<Car>.from(json["Results"].map((x) => Car.fromJson(x))));
}

class Car {
  final int makeId;
  final String makeName;

  Car({required this.makeId, required this.makeName});

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        makeId: json["Make_ID"],
        makeName: json["Make_Name"],
      );
}
