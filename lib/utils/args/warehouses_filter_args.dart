import 'package:equatable/equatable.dart';

class FilterArgs extends Equatable {
   String search="";

   FilterArgs(
      {required this.search,});

  @override
  List<Object?> get props => [this.search,];
}
