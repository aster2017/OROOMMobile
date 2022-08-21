import 'package:get/get.dart';

class SearchController extends GetxController {
  final checkinDate = DateTime.now().obs;
  final checkOutDate = DateTime.now().add(Duration(days: 1)).obs;
  final adults = 1.obs;

  final childrens = 0.obs;
  final rooms = 1.obs;
  final Rx<List<Map<String, dynamic>>> childrensAge =
      Rx<List<Map<String, dynamic>>>([]);
  final Rx<double> roomLowerVal = Rx<double>(0.0);
  final Rx<double> roomUpperVal = Rx<double>(1000.0);
  final ratings = [].obs;
  final offer = false.obs;
}
