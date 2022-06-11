import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.productName,
    required this.authorName,
    required this.productPreview,
    required this.authorPreview,
  }) : super(key: key);

  final String productName;
  final String productPreview;

  final String authorName;
  final String authorPreview;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,

      child: Padding(
        padding: const EdgeInsets.all(6),
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.asset('images/$productPreview'),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productName,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10, // Image radius
                        backgroundImage: Image.asset('images/$authorPreview').image,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                        child: Text(
                          authorName,
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
