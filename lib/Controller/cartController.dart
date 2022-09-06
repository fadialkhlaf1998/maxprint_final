import 'package:get/get.dart';
import 'package:maxprint_final/Model/LineItem.dart';
import 'package:maxprint_final/Model/MyOrder.dart';
import 'package:maxprint_final/Model/Order.dart';
import 'package:maxprint_final/Model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {

  var loading = false.obs;
  Rx<String> total="0.00".obs;
  var myOrd = <MyOrder>[].obs;
  List <LineItem> line_items_api = <LineItem>[];

  getTotal() {
    double x=0;
    for (MyOrder elm in myOrd) {
      x += double.parse(elm.product.value.variants!.first.price!) * elm.quantity.value;
    }
    total.value = x.toString();
    return total.value;
  }
  increaseOnCart(MyOrder myOrder, index){
    myOrd[index].quantity.value++;
    double x =  myOrd[index].quantity.value * double.parse(myOrd[index].product.value.variants!.first.price!);
    myOrd[index].price.value=x.toString();
    getTotal();
    saveCart();
  }
  decreaseFromCart(MyOrder myOrder,index){
    if(myOrd[index].quantity.value > 1){
      myOrd[index].quantity.value--;
      double x =  myOrd[index].quantity.value * double.parse(myOrd[index].product.value.variants!.first.price!);
      myOrd[index].price.value=x.toString();
      getTotal();
      saveCart();
    }else{
      deleteFromCart(myOrder);
    }
  }
  addToCart(Product product, int count){
    for(int i=0;i<myOrd.length;i++){
      if(myOrd[i].product.value.id == product.id){
        myOrd[i].quantity.value = myOrd[i].quantity.value + count;
        // link = myOrd[i].link.value;
        double x = myOrd[i].quantity.value * double.parse(product.variants!.first.price!);
        myOrd[i].price.value = x.toString();
        getTotal();
        saveCart();
        return ;
      }
    }
    double x = count * double.parse(product.variants!.first.price!);
    MyOrder myOrder = MyOrder(product:product.obs,quantity:count.obs,price:"0.0".obs);
    myOrd.add(myOrder);
    saveCart();
    getTotal();
    return ;
  }
  deleteFromCart(MyOrder myOrder){
    myOrd.removeAt(myOrd.indexOf(myOrder));
    saveCart();
  }
  saveCart() {
    Order order = Order();
    order.lineItems = <OrderLineItem>[];
    line_items_api = <LineItem>[];
    for(int i=0;i<myOrd.length;i++){
      line_items_api.add(LineItem(myOrd[i].quantity.value, myOrd[i].product.value.variants!.first.id!));
      order.lineItems!.add(OrderLineItem(
          product: myOrd[i].product.value,
          price: myOrd[i].price.value,
          quantity: myOrd[i].quantity.value,
      ));
    }
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("order", order.toJson());
    });
  }
  Future<void> loadCart() async {
    try{
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String ord = prefs.getString("order")??'o';
      Order order = Order.fromJson(ord);
      for (int i = 0; i < order.lineItems!.length; i++) {
        myOrd.add(
            MyOrder(product: order.lineItems![i].product!.obs,
              quantity: order.lineItems![i].quantity!.obs,
              price: order.lineItems![i].price!.obs,
            )
        );
      }
      getTotal();

    }
    catch(e){
      return;
    }
  }
  clearCart() {
    myOrd.clear();
    SharedPreferences.getInstance().then((prefs){
     prefs.remove("order");
    });
    getTotal();
  }

  clearUploadDesignUrls() async {
    await SharedPreferences.getInstance().then((prefs){
      prefs.remove("uploadDesign");
    });
  }

}