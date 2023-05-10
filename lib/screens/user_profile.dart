import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/debug_admin.dart';
import '../screens/category_add_edit.dart';
import '../screens/category_list.dart';
import '../common/customNavBar.dart';
import '../controllers/authController.dart';
import '../controllers/navController.dart';
import '../controllers/userController.dart';
import '../screens/home.dart';
import '../services/database.dart';
import '../utils/colors.dart';
import '../common/botao_simples.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  final TextEditingController aboutTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();

  static String title = 'Profile';

  UserController _userController = Get.find<UserController>();
  NavController _navController = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    nameTextController.text = _userController.user.name ?? "";
    aboutTextController.text = _userController.user.about ?? "";

    _userController.imageTempUrl.value = _userController.user.userImage!;

    return Scaffold(
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        backgroundColor: corFundoClara,
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
        bottomNavigationBar: CustomNavBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      areaFoto(context),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.contact_page, color: corPrimaria),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide:
                                  BorderSide(width: 2, color: corPrimaria),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(90.0)),
                                borderSide:
                                    BorderSide(width: 2, color: corPrimaria)),
                            // hintStyle: GoogleFonts.lato(fontStyle: FontStyle.normal),
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: corPrimariaEscura)),
                        controller: nameTextController,
                        autocorrect: false,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                          decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.description, color: corPrimaria),
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
                              hintText: 'Sobre min...',
                              hintStyle: TextStyle(color: corPrimariaEscura)),
                          controller: aboutTextController,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.black),
                          maxLines: 3),
                      SizedBox(height: 10),
                      areaBotoesInferiores(context)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Etc...',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.w300)),
                      SizedBox(height: 10),
                      BotaoSimples(
                        executarAcao: () async {
                          print("\n\n* Logout \n");
                          Get.find<AuthController>().signOut();

                          _navController.selectedIndex = 0;
                        },
                        iconeBotao:
                            Icon(Icons.logout, size: 20, color: Colors.white),
                        textoBotao: "Sair / Efetuar Logout",
                      )
                    ],
                  ),
                ),
                _userController.user.role == 'admin'
                    ? SizedBox(height: 20)
                    : Container(),
                _userController.user.role == 'admin'
                    ? Container(
                        padding: EdgeInsets.all(20),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Admin...',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w300)),
                            SizedBox(height: 10),
                            BotaoSimples(
                              executarAcao: () async {
                                Get.to(CategoryListScreen());
                              },
                              iconeBotao: Icon(Icons.filter_1_outlined,
                                  size: 20, color: Colors.white),
                              textoBotao: "Categoria - Gerenciar",
                            ),
                            SizedBox(height: 10),
                            BotaoSimples(
                              executarAcao: () async {
                                Get.to(CategoryAddEditScreen());
                              },
                              iconeBotao: Icon(Icons.add_circle_outline,
                                  size: 20, color: Colors.white),
                              textoBotao: "Categoria - Adicionar",
                            ),
                            SizedBox(height: 10),
                            BotaoSimples(
                              executarAcao: () async {
                                Get.to(DebugAdminScreen());
                              },
                              iconeBotao: Icon(Icons.add_circle_outline,
                                  size: 20, color: Colors.white),
                              textoBotao: "Operacoes Especiais",
                            )
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ));
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
        if (croppedImage != null) {
          _userController.imageTempUrl.value =
              await Database().uploadPictureGetUrl(File(croppedImage.path));
        }
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
              GetX<UserController>(
                  // init: UserController(),
                  initState: (_) {},
                  builder: (userController) {
                    return userController.imageTempUrl.value != ''
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
                                imageUrl: userController.imageTempUrl.value,
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
        child: GetX<UserController>(
          // init: UserController(),
          initState: (_) {},
          builder: (userController) {
            return !userController.isLoading()
                ? BotaoSimples(
                    executarAcao: () async {
                      print("\n\n* SALVAR PROFILE \n");

                      if ((nameTextController.text.trim() != '')) {
                        await userController.edit(
                            id: _userController.user.id!,
                            about: aboutTextController.text.trim(),
                            name: nameTextController.text.trim(),
                            userImage: userController.imageTempUrl.value);

                        _navController.selectedIndex = 0;
                        Get.off(Home());
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
                    iconeBotao: Icon(Icons.save, size: 20, color: Colors.white),
                    textoBotao: "Salvar",
                  )
                : Container(
                    height: 20,
                    width: 20,
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(corPrimariaClara)),
                    ),
                  );
          },
        ),
      ),
    );
  }

  // ##################################################################################################
  // ##################################################################################################
  // ##################################################################################################
}
