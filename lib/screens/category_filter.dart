import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/customNavBar.dart';
import '../widgets/categoryCard.dart';
import '../controllers/categoryController.dart';
import '../utils/colors.dart';

class CategoryFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Escolha Categoria",
            style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w300)),
        backgroundColor: corFundoClara,
        elevation: 0,
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [corFundoClara, corFundoEscura],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                ),
                height: MediaQuery.of(context).size.height * 0.80,
                width: double.infinity,
                // color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.only(top: 1, left: 16, right: 16),
                  child: activeCourses(showActive: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget activeCourses({bool showActive = true}) {
    return GetX<CategoryController>(
      init: Get.put<CategoryController>(CategoryController()),
      builder: (CategoryController? categoryController) {
        if (categoryController?.isLoading.value == true) {
          return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(corPrimariaClara)));
        } else {
          if (categoryController != null &&
              categoryController.categoryList.length > 0) {
            return GridView.count(
              shrinkWrap: true,
              // childAspectRatio: 1.0 / 1.8,
              // padding: EdgeInsets.only(left: 10, right: 10),
              scrollDirection: Axis.vertical,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 15,
              children: categoryController.categoryList.map((category) {
                return CategoryCard(category: category);
              }).toList(),
            );

            // ListView.separated(
            //   separatorBuilder: (BuildContext context, int index) {
            //     return SizedBox(
            //       height: 10,
            //     );
            //   },
            //   padding: EdgeInsets.only(bottom: 15),
            //   itemCount: categoryController.categoryList.length,
            //   itemBuilder: (_, index) {
            //     return Row(
            //       children: [
            //         Expanded(
            //           flex: 60,
            //           child: Container(
            //             child: CategoryCardSimple(category: categoryController.categoryList[index]),
            //           ),
            //         ),
            //         Expanded(
            //           flex: 20,
            //           child: Container(
            //             // height: 140,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceAround,
            //               mainAxisSize: MainAxisSize.max,
            //               children: [
            //                 GestureDetector(
            //                     onTap: () => Get.to(CategoryAddEditScreen(), arguments: categoryController.categoryList[index]),
            //                     child: SizedBox(height: 50, child: Icon(Icons.edit, color: Colors.black, size: 30))),
            //                 GestureDetector(onTap: () {}, child: SizedBox(height: 50, child: Icon(Icons.delete, color: Colors.red, size: 30)))
            //               ],
            //             ),
            //           ),
            //         )
            //       ],
            //     );
            //   },
            // );
          } else {
            return Text("Lista Vazia...");
          }
        }
      },
    );
  }
}
