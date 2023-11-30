sealed class UserModel {

  final int id;
  final String? displayName;
  final String email;
  final String? photoURL;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    this.photoURL,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelADM.fromMap(json),
      'CUSTOMER' => UserModelCustomer.fromMap(json),
      _ => throw ArgumentError('User profile not found'),
    };
  }
}

class UserModelADM extends UserModel {


  final List<String>? workDays;
  final List<int>? workHours;

  UserModelADM({
    required super.id,
    required super.displayName,
    required super.email,
    super.photoURL,
    this.workDays,
    this.workHours,
  });

  factory UserModelADM.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'displayName': final String displayName,
        'email': final String email,
      } =>
        UserModelADM(
          id: id,
          displayName: displayName,
          email: email,
          photoURL: json['photoURL'],
          // ignore: avoid_dynamic_calls
          workDays: json['work_days']?.cast<String>(),
          // ignore: avoid_dynamic_calls
          workHours: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

}

class UserModelCustomer extends UserModel {


  final List<String> workDays;
  final List<int> workHours;
  final int barbershopId;

  UserModelCustomer({
    required super.id,
    required super.displayName,
    required super.email,
    required this.barbershopId,
    super.photoURL,
    required this.workDays,
    required this.workHours,
  });

  factory UserModelCustomer.fromMap(Map<String, dynamic> json) {


    return switch (json) {
      {
        'id': final int id,
        'name': final String displayName,
        'email': final String email,
        'barbershop_id': final int barbershopId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserModelCustomer(
          id: id,
          displayName: displayName,
          email: email,
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
          photoURL: json['photoURL'],
          barbershopId: barbershopId,
        ),
      _ => throw ArgumentError('Invalid UserModelCustomer JSON: $json'),
    };
  }

}
