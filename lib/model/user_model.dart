class UserItem {
  final int id;
  final int metaId;
  final String fullName;
  final String shortName;
  final String firstName;
  final String secondName;
  final String thirdName;
  final String employeeIdNumber;

  UserItem({
    required this.id,
    required this.metaId,
    required this.fullName,
    required this.shortName,
    required this.firstName,
    required this.secondName,
    required this.thirdName,
    required this.employeeIdNumber,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      id: json['id'],
      metaId: json['meta_id'],
      fullName: json['full_name'],
      shortName: json['short_name'],
      firstName: json['first_name'],
      secondName: json['second_name'],
      thirdName: json['third_name'],
      employeeIdNumber: json['employee_id_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meta_id': metaId,
      'full_name': fullName,
      'short_name': shortName,
      'first_name': firstName,
      'second_name': secondName,
      'third_name': thirdName,
      'employee_id_number': employeeIdNumber,
    };
  }
}
