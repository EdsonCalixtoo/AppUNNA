import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LikeButton extends StatefulWidget {
  bool isLiked;
  final Function? onTap;

  LikeButton({Key? key, this.isLiked = false, required this.onTap})
      : super(key: key);
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool showAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (widget.isLiked == false) {
            setState(() {
              widget.isLiked = !widget.isLiked;
              showAnimation = true;
              // controller.play();
            });
          } else {
            setState(() {
              widget.isLiked = !widget.isLiked;
            });
          }

          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: showAnimation == false
            ? Container(
                // color: Colors.blue,
                height: 50,
                width: 50,
                child: Center(
                  child: Icon(
                    widget.isLiked == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 25,
                    color: widget.isLiked == true ? Colors.red : Colors.black54,
                  ),
                ),
              )
            : SizedBox(
                width: 50,
                height: 50,
                child: Lottie.asset(
                  "assets/lottie/5236-like.json",
                  repeat: false,
                  reverse: false,
                )),
      ),
    );
  }
}
