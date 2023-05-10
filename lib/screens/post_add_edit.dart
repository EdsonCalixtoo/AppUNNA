import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/categoryController.dart';
import '../controllers/userController.dart';
import '../services/database.dart';
import '../controllers/postController.dart';
import '../models/post.dart';
import '../utils/colors.dart';
import '../common/botao_simples.dart';

// ignore: must_be_immutable
class PostAddEditScreen extends StatelessWidget {
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController categoryTextController = TextEditingController();

  static String title = 'Adicionar Categoria';
  static String idEditing = '';

  PostController _postController = Get.find<PostController>();

  final categorias = ['geral'];

  CategoryController _categoryController = Get.find<CategoryController>();
  UserController _userController = Get.find<UserController>();

  showLocaleDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) => AlertDialog(
        title: Text('escolha categoria'),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                categoryTextController.text =
                    _categoryController.categoryList[index].name;
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 9),
                // color: Colors.blue,
                child: Text(_categoryController.categoryList[index].name),
              ),
            ),
            separatorBuilder: (context, index) => Divider(color: Colors.black),
            itemCount: _categoryController.categoryList.length,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      print('\n\n\n -----------------');
      print(Get.arguments);

      var model = Get.arguments as PostModel;

      idEditing = model.id!;

      bodyController.text = model.body!;
      categoryTextController.text = model.category!;
      title = 'Editar Postagem';
      _postController.isEditing.value = true;
    } else {
      title = 'Nova Postagem';
      idEditing = '';
      _postController.isEditing.value = false;
      categoryTextController.text = 'geral';
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
              colors: [
                corFundoClara,
                corFundoClara,
                corFundoClara,
                corFundoClara,
                corFundoClara,
                corFundoClara
              ],
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
                      areaFoto(context),
                      SizedBox(height: 16),
                      TextFormField(
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.loyalty, color: corPrimaria),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35.0)),
                                borderSide:
                                    BorderSide(width: 2, color: corPrimaria),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(35.0)),
                                  borderSide:
                                      BorderSide(width: 2, color: corPrimaria)),
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Texto...',
                              hintStyle: TextStyle(color: corPrimariaEscura)),
                          controller: bodyController,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black),
                          maxLines: 3),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                              flex: 70,
                              child: TextFormField(
                                onTap: () => showLocaleDialog(context),
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.explore, color: corPrimaria),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(90.0)),
                                      borderSide: BorderSide(
                                          width: 2, color: corPrimaria),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(90.0)),
                                        borderSide: BorderSide(
                                            width: 2, color: corPrimaria)),
                                    // hintStyle: GoogleFonts.lato(fontStyle: FontStyle.normal),
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: 'Categoria',
                                    hintStyle:
                                        TextStyle(color: corPrimariaEscura)),
                                controller: categoryTextController,
                                autocorrect: false,
                                readOnly: true,
                                focusNode: FocusNode(),
                                enableInteractiveSelection: false,
                                style: TextStyle(color: Colors.black),
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 30,
                            child: BotaoSimples(
                              executarAcao: () => showLocaleDialog(context),
                              iconeBotao: Icon(Icons.list_sharp,
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

  Widget areaFoto(BuildContext context) {
    void imageSelected(File? image) async {
      if (image != null) {
        CroppedFile? croppedImage =
            await ImageCropper.platform.cropImage(sourcePath: image.path);

        print("\n\n\nCHEGUEI AQUI");

        _postController.imageTempUrl.value =
            await Database().uploadPictureGetUrl(File(croppedImage!.path));
      }
    }

    return Container(
        height: 145,
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: corPrimaria, //                   <--- border color
            width: 2.0,
          ),
          borderRadius: new BorderRadius.all(Radius.circular(35.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              GetX<PostController>(
                  // init: UserController(),
                  initState: (_) {},
                  builder: (postController) {
                    return postController.imageTempUrl.value != ''
                        ? Container(
                            height: 120,
                            width: 120,
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: ClipRRect(
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(10.0)),
                              child: CachedNetworkImage(
                                imageUrl: postController.imageTempUrl.value,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Align(
                                  alignment: Alignment.topCenter,
                                  child: Center(
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              corPrimariaClara)),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          )
                        : Container(
                            height: 120,
                            width: 120,
                            decoration: new BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(5.0))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo_size_select_actual,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  Text(
                                    "Defina\nImagem",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ]),
                          );
                  }),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BotaoSimples(
                        executarAcao: () async {
                          final ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            imageSelected(File(image.path));
                          }
                        },
                        iconeBotao: Icon(Icons.photo_album,
                            size: 20, color: Colors.white),
                        textoBotao: "Galeria",
                      ),
                      SizedBox(height: 10),
                      BotaoSimples(
                        executarAcao: () async {
                          final ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.camera);

                          if (image == null) return;

                          imageSelected(File(image.path));
                        },
                        iconeBotao: Icon(Icons.camera_alt,
                            size: 20, color: Colors.white),
                        textoBotao: "Camera",
                      ),
                    ]),
              ),
              // SizedBox(width: 10),
            ],
          ),
        ));
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
                child: GetX<PostController>(
                    // init: UserController(),
                    initState: (_) {},
                    builder: (postController) {
                      return !postController.isLoading()
                          ? BotaoSimples(
                              executarAcao: () async {
                                print("\n\n* SALVAR \n");

                                // print(_userController.user.email);
                                // print(_userController.user.name);
                                // print(_userController.user.id);
                                print(_userController.user);

                                if ((bodyController.text.trim() != '') &&
                                    (categoryTextController.text.trim() !=
                                        '')) {
                                  if (_postController.isEditing.value) {
                                    print('EDIT SALVE: idEditing=' + idEditing);
                                    await postController.edit(
                                        id: idEditing,
                                        body: bodyController.text.trim(),
                                        category:
                                            categoryTextController.text.trim(),
                                        userHandle: _userController.user.email!,
                                        userName: _userController.user.name!,
                                        userImage:
                                            _userController.user.userImage!,
                                        postImage:
                                            postController.imageTempUrl.value);
                                  } else {
                                    await postController.add(
                                        body: bodyController.text.trim(),
                                        category:
                                            categoryTextController.text.trim(),
                                        userHandle: _userController.user.email!,
                                        userName: _userController.user.name!,
                                        userImage:
                                            _userController.user.userImage!,
                                        postImage:
                                            postController.imageTempUrl.value);
                                  }

                                  postController.get();
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
                              textoBotao: "Postar",
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
