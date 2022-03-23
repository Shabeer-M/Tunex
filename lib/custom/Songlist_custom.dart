import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Songlist_custom extends StatelessWidget {
  final bool subtite;
  final bool trailicon;
  final int index;
  final String text;
  final String url;

  Songlist_custom(
      {Key? key,
      required this.subtite,
      required this.trailicon,
      required this.index,
      required this.text,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.12,
                    height: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: QueryArtworkWidget(
                      nullArtworkWidget: Image.asset(
                        "assets/abstract-vector-element-music-design-260nw-1031659504.webp",
                      ),
                      id: int.parse(url),
                      type: ArtworkType.AUDIO,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      Visibility(
                        visible: subtite,
                        child: Text(
                          '$index Videos',
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              // fontSize:  MediaQuery.of(context).size.width * 0.06,
                              color: Colors.grey),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
