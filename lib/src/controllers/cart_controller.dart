import 'package:get/get.dart';
import '../services/http_service.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  var cartList = [].obs;

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  void fetchCart() async {
    try {
      isLoading(true);
      var cart = await HttpService.fetchCart();
      if (cart != null) {
        cartList.value = cart;
      }
    } finally {
      isLoading(false);
    }
  }
}
