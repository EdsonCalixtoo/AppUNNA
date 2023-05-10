import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/userController.dart';
import '../utils/firebase.dart';

class DebugAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('debug'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    // print('Firebase - criar posts randomicos');
                    // await copiaEtapasDoHack();
                    criarPostsRandomicos();
                  },
                  child: Text('Firebase - criar posts randomicos'),
                ),
              ),
              //
              //
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    criarPostRandomicoEmMass(50);
                  },
                  child: Text('Criar 50 posts randomicos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    // await testaAtualizacaoEntregavel();
                    apagarConteudoTabela();
                  },
                  child: Text('Firebase - apagar TODA tabela'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    // await testaPegarListaAreasAtuacaoHackatonAtual();
                    // Database().userProfileData('edson@unna.com');

                    UserController _userController = Get.find<UserController>();

                    _userController.getUserProfileNumbers('edson@unna.com');
                  },
                  child: Text('Usuario - pegar dados profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
