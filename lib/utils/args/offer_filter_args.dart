import 'package:equatable/equatable.dart';

class OfferFilterArgs extends Equatable {
   String? search;
   String? barcode="";
   String? companyTitle="";
   String? typeTitle="";
   String? warehouseTitle="";
   List<String>?  company;
   List<String>?  type;
   List<String>?  warehouse;

   OfferFilterArgs(
      {this.search,
      this.type,
      this.company,
      this.warehouse,
      this.barcode,
      this.companyTitle,
      this.typeTitle,
      this.warehouseTitle,});

  @override
  List<Object?> get props => [this.search,
    this.warehouse,
    this.type,
    this.company,
    this.barcode,
    this.companyTitle,
    this.typeTitle,
    this.warehouseTitle,];
}
