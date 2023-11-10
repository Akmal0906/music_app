import 'package:get/get.dart';

class FavourController extends GetxController{
  var isLiked=false.obs;
isFavour(){
  isLiked.value=!isLiked.value;
  update();
}

@override
  void onReady(){
  super.onReady();
}

}