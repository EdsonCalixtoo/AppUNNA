import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../controllers/authController.dart';
import '../screens/login.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login"),
      // ),

      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [corFundoClara, corFundoClara, corFundoEscura],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    // Image.asset("Logo1.png", height: 200.0, width: 200.0),

                    !isKeyboardVisible
                        // ? Text("Moagrama", style: TextStyle(fontFamily: 'GrandHotel', fontSize: 55))
                        ? Image.asset(
                            'assets/images/logo.png',
                            height: 200,
                            width: 200,
                            // color: Colors.white,
                            // colorBlendMode: BlendMode.darken,
                            fit: BoxFit.fitHeight,
                          )
                        : Container(),
                    SizedBox(height: 36),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.perm_identity,
                              color: corPrimariaEscura),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide:
                                BorderSide(width: 2, color: corPrimariaEscura),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                  width: 2, color: corPrimariaEscura)),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Nome',
                          hintStyle: TextStyle(color: corPrimariaEscura)),
                      controller: nameController,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: corPrimariaEscura),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined,
                              color: corPrimariaEscura),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide:
                                BorderSide(width: 2, color: corPrimariaEscura),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                  width: 2, color: corPrimariaEscura)),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: corPrimariaEscura)),
                      controller: emailController,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: corPrimariaEscura),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.lock_open, color: corPrimariaEscura),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(90.0)),
                            borderSide:
                                BorderSide(width: 2, color: corPrimariaEscura),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide(
                                  width: 2, color: corPrimariaEscura)),
                          // hintStyle: GoogleFonts.lato(fontStyle: FontStyle.normal),
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: 'Senha',
                          hintStyle: TextStyle(color: corPrimariaEscura)),
                      controller: passwordController,
                      obscureText: true,
                      autocorrect: false,
                      style: TextStyle(color: corPrimariaEscura),
                    ),
                    SizedBox(height: 36),
                    ElevatedButton(
                      onPressed: () {
                        if ((emailController.text.trim() != '') &&
                            (passwordController.text.trim() != '')) {
                          controller.createUser(nameController.text,
                              emailController.text, passwordController.text);
                        } else {
                          Get.snackbar(
                            'Opa, ta errado manolo',
                            'Preenche os campos direito que vai!',
                            snackPosition: SnackPosition.TOP,
                            duration: Duration(seconds: 5),
                            colorText: corPrimariaEscura,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              corPrimariaClara,
                              corPrimaria,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                              minWidth: 88.0,
                              minHeight:
                                  36.0), // min sizes for Material buttons
                          alignment: Alignment.center,
                          height: 55,
                          child: const Text(
                            'CADASTRAR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 21,
                                letterSpacing: 1.2,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    TextButton(
                      child: Text("Acessar",
                          style: TextStyle(color: corPrimariaEscura)),
                      onPressed: () {
                        // Get.back();
                        Get.off(Login());
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
