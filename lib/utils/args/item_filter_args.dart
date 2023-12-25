import 'package:equatable/equatable.dart';

class ItemFilterArgs extends Equatable {
  String? search;
  String? barcode="";
  String? companyTitle="";
  String? typeTitle="";
  String? warehouseTitle="";
  List<String> sortByTitle=[];
  List<String> valueByTitle=[];
  List<String>?  company;
  List<String>?  type;
  List<String>?  warehouse;
  List<String>? sortBy;

  ItemFilterArgs(
      {this.search,
        this.type,
        this.company,
        this.warehouse,
        this.barcode,
        this.companyTitle,
        this.typeTitle,
        this.sortBy,
        this.warehouseTitle,});

  @override
  List<Object?> get props => [this.search,
    this.warehouse,
    this.type,
    this.company,
    this.barcode,
    this.companyTitle,
    this.typeTitle,
    this.sortBy,
    this.warehouseTitle,];
}
