import 'package:flutter/material.dart';

class VideoMessage extends StatelessWidget {
  const VideoMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/images/Video Place Here.png"),
            ),
            Container(
              height: 25,
              width:25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white
              ),
              child: Icon(
                Icons.play_arrow,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
