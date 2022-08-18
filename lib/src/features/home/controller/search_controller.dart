import 'package:get/get.dart';

class SearchController extends GetxController {
  final checkinDate = DateTime.now().obs;
  final checkOutDate = DateTime.now().add(Duration(days: 1)).obs;
  final adults = 1.obs;

  final childrens = 0.obs;
  final rooms = 1.obs;
  final childrensAge = [].obs;
  final roomLowerVal = (0.0).obs;
  final roomUpperVal = (500.0).obs;
  final ratings = [].obs;
  final offer = false.obs;
}
