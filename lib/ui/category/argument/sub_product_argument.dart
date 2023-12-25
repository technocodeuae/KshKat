import '../../../models/home/category_model.dart';
import '../../../models/cart/products_cart.dart';

class SubArgument {
  final int? mainId;
  final String? name;
  final token;
  final address;


  SubArgument(this.name, this.mainId, this.address,this.token);
}