import 'package:flutter/material.dart';
import '../utils/colors.dart';

class BotaoCortado extends StatelessWidget {
  final Function executarAcao;
  final String textoBotao;
  final Icon? iconeBotao;

  const BotaoCortado({
    Key? key,
    required this.executarAcao,
    required this.textoBotao,
    this.iconeBotao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(90.0), topRight: Radius.circular(90.0)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(90.0),
                topRight: Radius.circular(90.0)),
          ),
          padding: const EdgeInsets.all(0.0),
        ),
        onPressed: () {
          executarAcao();
        },
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[corPrimaria, corPrimaria, corPrimariaClara],
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(90.0),
                topRight: Radius.circular(90.0)),
          ),
          child: Container(
              constraints: const BoxConstraints(
                  minWidth: 88.0,
                  minHeight: 36.0), // min sizes for Material buttons
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (iconeBotao != null)
                    Container(
                      child: iconeBotao,
                    ),
                  if (iconeBotao != null)
                    SizedBox(
                      width: 8,
                    ),
                ],
              )),
        ),
      ),
    );
  }
}
