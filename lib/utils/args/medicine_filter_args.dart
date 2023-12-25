import 'package:equatable/equatable.dart';

class MedicineFilterArgs extends Equatable {
  String? search;
  String? barcode="";
  String? companyTitle="";
  String? typeTitle="";
  String? warehouseTitle="";
  List<String> sortByTitle=[];
  List<String> valueByTitle=[];
  String? compositionsTitle="";
  List<String>?  company;
  List<String>?  type;
  List<String>?  warehouse;
  List<String>?  compositions;
  List<String>? sortBy;
  MedicineFilterArgs(
      {this.search,
        this.type,
        this.company,
        this.warehouse,
        this.compositions,
        this.barcode,
        this.companyTitle,
        this.typeTitle,
        this.sortBy,
        this.warehouseTitle,
        this.compositionsTitle});

  @override
  List<Object?> get props => [this.search,
    this.warehouse,
    this.compositions,
    this.type,
    this.company,
    this.barcode,
    this.companyTitle,
    this.typeTitle,
    this.sortBy,
    this.warehouseTitle,
    this.compositionsTitle];
}
