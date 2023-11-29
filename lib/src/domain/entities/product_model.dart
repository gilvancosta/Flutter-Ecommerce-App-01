sealed class ProductModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  ProductModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => ProductModelADM.fromMap(json),
      'EMPLOYEE' => ProductModelEmployee.fromMap(json),
      _ => throw ArgumentError('User profile not found'),
    };
  }
}

class ProductModelADM extends ProductModel {
  final List<String>? workDays;
  final List<int>? workHours;
  ProductModelADM({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });

  factory ProductModelADM.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        ProductModelADM(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}

class ProductModelEmployee extends ProductModel {
  final int barbershopId;
  final List<String> workDays;
  final List<int> workHours;

  ProductModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    required this.barbershopId,
    super.avatar,
    required this.workDays,
    required this.workHours,
  });

  factory ProductModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barbershopId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        ProductModelEmployee(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          barbershopId: barbershopId,
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
