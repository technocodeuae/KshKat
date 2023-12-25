import 'package:equatable/equatable.dart';

class UserFilterArgs extends Equatable {
   String? userName;
   String? role;
   List<String>? titles;
   List<String>? companies;
   List<int>? countries;
   String? department;
   int? sUserName;
   int? sRole;


   UserFilterArgs(
      {this.titles,
      this.role,
      this.department,
      this.sRole,
      this.companies,
      this.countries,
      this.sUserName,
      this.userName,});

  @override
  List<Object?> get props => [this.titles,
    this.role,
    this.department,
    this.sRole,
    this.countries,
    this.companies,
    this.sRole,
    this.sUserName,
    this.userName,];
}
