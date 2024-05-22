import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final int accessTypeId;
  final String name;
  final String email;
  final String cpf;
  final String phone;
  final String image;
  final bool mobileAccess;
  final bool adminAccess;
  final bool firstAccess;
  final int? mainCompanyId;

  final bool status;

  const UserModel({
    required this.id,
    required this.mainCompanyId,
    required this.accessTypeId,
    required this.name,
    required this.email,
    required this.cpf,
    required this.phone,
    required this.image,
    required this.mobileAccess,
    required this.adminAccess,
    required this.firstAccess,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        mainCompanyId,
        accessTypeId,
        name,
        email,
        cpf,
        phone,
        image,
        mobileAccess,
        adminAccess,
        firstAccess,
        status,
      ];
}
