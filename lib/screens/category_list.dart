import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/categoryController.dart';
import '../screens/category_add_edit.dart';
import '../utils/colors.dart';
import '../widgets/categoryCardSimple.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Categorias",
            style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w300)),
        backgroundColor: corFundoClara,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => Get.to(CategoryAddEditScreen()),
            child: Icon(
              Icons.add,
              size: 35,
              color: corPrimaria,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
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
                padding: EdgeInsets.all(5),
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
                  child: activeCategories(showActive: true),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget activeCategories({bool showActive = true}) {
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
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10,
                );
              },
              padding: EdgeInsets.only(bottom: 15),
              itemCount: categoryController.categoryList.length,
              itemBuilder: (_, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 60,
                      child: Container(
                        child: CategoryCardSimple(
                            category: categoryController.categoryList[index]),
                      ),
                    ),
                    Expanded(
                      flex: 20,
                      child: Container(
                        // height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            GestureDetector(
                                onTap: () => Get.to(CategoryAddEditScreen(),
                                    arguments:
                                        categoryController.categoryList[index]),
                                child: SizedBox(
                                    height: 50,
                                    child: Icon(Icons.edit,
                                        color: Colors.black, size: 30))),
                            GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                    height: 50,
                                    child: Icon(Icons.delete,
                                        color: Colors.red, size: 30)))
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          } else {
            return Text("Lista Vazia...");
          }
        }
      },
    );
  }
}
