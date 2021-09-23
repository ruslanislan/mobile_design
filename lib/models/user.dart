import 'address.dart';

class User {
  int? id;
  String? email;
  String? phone;
  String? hashPassword;
  String? name;
  String? secondName;
  String? lastName;
  String? dateBirthday;
  int? typeAccount; // 0 - ученик, 1 - педагог, 2 - родитель
  bool isCurator = false;
  String? avatar;
  Address? schoolLocation;
  User({ this.email, this.typeAccount = 0, this.phone });
}