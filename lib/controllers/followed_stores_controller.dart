import 'package:get/get.dart';
import 'package:gurkha_pasal/consts/consts.dart' as consts;
import 'package:gurkha_pasal/models/store.dart';

class FollowedStoresController extends GetxController {
  var followedStores = <Store>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate fetching followed stores (replace with actual data fetching)
    followedStores.addAll([
      Store(
        id: "1",
        name: "Gurkha Store 1",
        logoUrl: "https://via.placeholder.com/150",
        followers: 1200,
      ),
      Store(
        id: "2",
        name: "Gurkha Store 2",
        logoUrl: "https://via.placeholder.com/150",
        followers: 850,
      ),
      Store(
        id: "3",
        name: "Gurkha Store 3",
        logoUrl: "https://via.placeholder.com/150",
        followers: 300,
      ),
    ]);
  }

  void followStore(Store store) {
    if (!followedStores.any((element) => element.id == store.id)) {
      followedStores.add(store);
      Get.snackbar(
        "Success",
        "Followed ${store.name}!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: consts.greenColor,
        colorText: consts.whiteColor,
      );
    }
  }

  void unfollowStore(int index) {
    final storeName = followedStores[index].name;
    followedStores.removeAt(index);
    Get.snackbar(
      "Success",
      "Unfollowed $storeName!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: consts.redColor,
      colorText: consts.whiteColor,
    );
  }
}
