import '../../../models/home/category_model.dart';
import '../../../models/cart/products_cart.dart';

class ProductsArgument {
  final String id;
  final List<CategoriesData> data;
  final List<Products> cart;
  final int index;
  final String? token;
  final String? address;


  ProductsArgument(this.data, this.id,this.cart, this.index, this.address,this.token);
}