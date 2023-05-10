import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/database.dart';
import '../utils/generical.dart';

void criarPostsRandomicos({bool exibirSnack = true}) {
  print('\n\n criarPostsRandomicos INICIO -----');
  String tabela = 'unna-posts';

  List<String> possiveisCategorias = [
    'geral',
    'esportes',
    'lazer',
    'bar',
    'serviços',
    'partys',
    'pets'
  ];
  List<String> possiveisAutores = [
    'maria@unna.com',
    'joao@unna.com',
    'angela@unna.com',
    'paula@unna.com'
  ];
  List<String> possiveisAutoresShort = ['maria', 'joao', 'angela', 'paula'];
  List<String> possiveisImagensAutores = [
    'https://firebasestorage.googleapis.com/v0/b/unna-449e5.appspot.com/o/unnaImagens%2Fuser0.png?alt=media&token=b878693e-6554-41f3-9b35-d4eeaf7d470c',
    'https://firebasestorage.googleapis.com/v0/b/unna-449e5.appspot.com/o/unnaImagens%2Fuser1.png?alt=media&token=141dbee3-31fd-49e4-b77b-880b511d5b17',
    'https://firebasestorage.googleapis.com/v0/b/unna-449e5.appspot.com/o/unnaImagens%2Fuser2.png?alt=media&token=708d0eed-5751-4704-8afd-b7d84fa87552',
    'https://firebasestorage.googleapis.com/v0/b/unna-449e5.appspot.com/o/unnaImagens%2Fuser3.png?alt=media&token=a07f1433-c819-41d9-8096-1d78b39663fa',
  ];
  List<String> possiveisImgPostagem = [
    'https://firebasestorage.googleapis.com/v0/b/unna-449e5.appspot.com/o/unnaImagens%2Fpost0.jpg?alt=media&token=ee51db9a-9791-4f27-88db-28b1a73bfa26',
    'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/unnaImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c',
    'https://firebasestorage.googleapis.com/v0/b/experimentosdiversos.appspot.com/o/unnaImagens%2FtesteImage.png?alt=media&token=53a7bdf7-a9e2-4752-a11f-d0ccd074936c',
    'https://firebasestorage.googleapis.com/v0/b/unna-449e5.appspot.com/o/unnaImagens%2Fpost1.jpg?alt=media&token=cfe9accd-4525-4624-b022-3690a3be0bd5',
  ];
  int autorRandomico = numeroRandomicoDentrUmRange(0, possiveisAutores.length);
  int categoriaRandomico =
      numeroRandomicoDentrUmRange(0, possiveisCategorias.length);

  var elemento = {
    'body': WordPair.random().asPascalCase,
    'commentCount': 0,
    'createdAt': Timestamp.now(),
    'likeCount': 0,
    'userHandle': possiveisAutores[autorRandomico],
    'userName': possiveisAutoresShort[autorRandomico],
    'userImage': possiveisImagensAutores[autorRandomico],
    'postImage': possiveisImgPostagem[autorRandomico],
    'category': possiveisCategorias[categoriaRandomico]
  };

  Database().createNewElement(tabela, elemento);

  if (exibirSnack) {
    Get.snackbar('Sucesso', 'criarPostsRandomicos - terminou',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
        colorText: Colors.white);
  }

  print(' criarPostsRandomicos FIM -----');
} //criarPostsRandomicos

void criarPostRandomicoEmMass(int qtde) {
  print('\n\n criarPostRandomicoEmMass INICIO -----');

  for (var i = 0; i < qtde; i++) {
    criarPostsRandomicos(exibirSnack: false);
  }

  Get.snackbar('Sucesso', 'criarPostsRandomicos - terminou',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 5),
      colorText: Colors.white);

  print(' criarPostRandomicoEmMass FIM -----');
} //criarPostRandomicoEmMass

void apagarConteudoTabela() async {
  print('\n\n criarPostsRandomicos INICIO -----');
  String tabela = 'unna-posts';

  await Database().cleanTable(tabela);

  Get.snackbar(
    'Sucesso',
    'apagarConteudoTabela - terminou',
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: 5),
    colorText: Colors.white,
  );

  print(' criarPostsRandomicos FIM -----');
} //apagarConteudoTabela
