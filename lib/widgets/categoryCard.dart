import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navController.dart';
import '../controllers/postController.dart';
import '../screens/home.dart';
import '../utils/colors.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final Function? onTap;

  const CategoryCard({
    Key? key,
    required this.category,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          Get.find<PostController>().updateFilter(category.name, '');
          Get.find<NavController>().selectedIndex = 0;
          Get.offAll(Home(), arguments: category.name);
        },
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: new BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: corPrimaria, //                   <--- border color
              width: 2.0,
            ),
            borderRadius: new BorderRadius.all(Radius.circular(35.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w300)),
              Icon(
                IconData(int.parse(category.icon), fontFamily: 'MaterialIcons'),
                size: 65,
              ),
              Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
