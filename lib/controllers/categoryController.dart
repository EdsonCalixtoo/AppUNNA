import 'package:get/get.dart';
import '../models/category.dart';
import '../services/database.dart';

class CategoryController extends GetxController {
  // Rx<List<PostModel>> categoryList = Rx<List<PostModel>>();
  final categoryList = [].obs;
  final categorySelected = "geral".obs;

  final isLoading = false.obs;
  final isEditing = false.obs;

  @override
  // ignore: must_call_super
  void onInit() {
    get();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> get() async {
    isLoading.value = true;

    List<CategoryModel> newCategories = [];
    newCategories = await Database().getCategories();

    if (newCategories.length > 0) {
      categoryList.clear();
      newCategories.forEach((post) => categoryList.add(post));
    }

    isLoading.value = false;
  } // get

  Future<void> add(String name, String iconText, int order) async {
    isLoading.value = true;

    Database().addCategory(
        {'name': name.trim(), 'iconText': iconText, 'order': order});

    isLoading.value = false;
  }

  Future<void> edit(String id, String name, String iconText, int order) async {
    isLoading.value = true;
    // await Future.delayed(Duration(seconds: 6));
    Database().editCategory(
        {'id': id, 'name': name.trim(), 'iconText': iconText, 'order': order});

    isLoading.value = false;
  }
}
