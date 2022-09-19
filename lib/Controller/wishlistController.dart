import 'package:get/get.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistController extends GetxController {

  RxList<Product> wishlist = <Product>[].obs;

  addToWishlist(Product wish) {
    for(int i=0;i<wishlist.length;i++){
      if(wish.id==wishlist[i].id){
        wishlist.removeAt(i);
      }
    }
    wishlist.add(wish);
    saveWishlist();
  }
  deleteFromWishlist(Product wish) {
    for(int i= 0; i< wishlist.length; i++) {
      if(wishlist[i].id == wish.id) {
        wishlist.removeAt(i);
        wish.favorite.value = false;
        saveWishlist();
      }
    }
  }
  saveWishlist() {
    Products wishlists = Products();
    wishlists.products = wishlist;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("wishlist", wishlists.toJson());
    });
  }
  Future<void> loadWishlist() async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? wish = preferences.getString("wishlist");
      Products wishlists = Products.fromJson(wish!);
      wishlist.addAll(wishlists.products!);
    }
    catch(e) {
      print(e.toString());
    }
  }
  bool isFavorite(Product product){
    for(int i=0;i<wishlist.length;i++){
      if(product.id==wishlist[i].id){
        return true;
      }
    }
    return false;
  }


}