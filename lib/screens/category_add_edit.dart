import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/categoryController.dart';
import '../models/category.dart';
import '../utils/colors.dart';
import '../common/botao_simples.dart';

// ignore: must_be_immutable
class CategoryAddEditScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController iconTextController = TextEditingController();
  final TextEditingController orderController = TextEditingController();

  static String title = 'Adicionar Categoria';
  static String idEditing = '';

  CategoryController _courseController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      print('\n\n\n -----------------');
      print(Get.arguments);

      var model = Get.arguments as CategoryModel;

      idEditing = model.id;
      orderController.text = model.order.toString();
      nameController.text = model.name;
      iconTextController.text = model.icon;
      title = 'Editar Categoria';
      _courseController.isEditing.value = true;
    } else {
      title = 'Adicionar Categoria';
      idEditing = '';
      _courseController.isEditing.value = false;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w300)),
        backgroundColor: corFundoClara,
        elevation: 0,
      ),
      bottomNavigationBar: areaBotoesInferiores(context),
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          // height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [corFundoClara, corFundoEscura],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.list_alt, color: corPrimaria),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).accentColor)),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Ordem',
                            hintStyle: TextStyle(color: corPrimariaEscura)),
                        controller: orderController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.loyalty, color: corPrimaria),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Theme.of(context).accentColor)),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: corPrimariaEscura)),
                        controller: nameController,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                              flex: 70,
                              child: TextFormField(
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.explore, color: corPrimaria),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Theme.of(context).accentColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:
                                                Theme.of(context).accentColor)),
                                    // hintStyle: GoogleFonts.lato(fontStyle: FontStyle.normal),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: 'Icone (numero, ex: 61103)',
                                    hintStyle:
                                        TextStyle(color: corPrimariaEscura)),
                                controller: iconTextController,
                                autocorrect: false,
                                style: TextStyle(color: Colors.black),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 30,
                            child: BotaoSimples(
                              executarAcao: () {
                                launchUrl(Uri.parse(
                                    'https://api.flutter.dev/flutter/material/Icons-class.html#constants'));
                              },
                              iconeBotao: Icon(Icons.image_search,
                                  size: 20, color: Colors.white),
                              textoBotao: "",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  // ###############################################################################################################
  // ###############################################################################################################
  // ###############################################################################################################

  Widget areaBotoesInferiores(context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 35,
                child: BotaoSimples(
                  executarAcao: () {
                    Get.back();
                  },
                  iconeBotao: Icon(Icons.cancel, size: 20, color: Colors.white),
                  textoBotao: "Cancelar",
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                flex: 35,
                child: GetX<CategoryController>(
                    // init: UserController(),
                    initState: (_) {},
                    builder: (categoryControler) {
                      return !categoryControler.isLoading()
                          ? BotaoSimples(
                              executarAcao: () async {
                                print("\n\n* SALVAR \n");

                                if ((orderController.text.trim() != '') &&
                                    (iconTextController.text.trim() != '')) {
                                  if (_courseController.isEditing.value) {
                                    print('EDIT SALVE: idEditing=' + idEditing);
                                    await categoryControler.edit(
                                        idEditing,
                                        nameController.text.trim(),
                                        iconTextController.text.trim(),
                                        int.parse(orderController.text.trim()));
                                  } else {
                                    await categoryControler.add(
                                        nameController.text.trim(),
                                        iconTextController.text.trim(),
                                        int.parse(orderController.text.trim()));
                                  }

                                  categoryControler.get();
                                  Get.back();
                                } else {
                                  Get.snackbar(
                                    'Opa, ta errado manolo',
                                    'Preenche os campos direito que vai!',
                                    snackPosition: SnackPosition.TOP,
                                    duration: Duration(seconds: 5),
                                    colorText: Colors.white,
                                  );
                                }
                              },
                              iconeBotao: Icon(Icons.save,
                                  size: 20, color: Colors.white),
                              textoBotao: "Salvar",
                            )
                          : Container(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        corPrimariaClara)),
                              ));
                    }),
              ),
            ],
          )),
    );
  }

  // ##################################################################################################
  // ##################################################################################################
  // ##################################################################################################
}
