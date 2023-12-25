import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlViewerWidget extends StatelessWidget {
  final String data;

  const HtmlViewerWidget({required this.data});
  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      tagsList: Html.tags..addAll(["bird", "flutter"]),
      style: {
        "table": Style(
          backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
        ),
        "tr": Style(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        "th": Style(
          padding: EdgeInsets.all(6),
          backgroundColor: Colors.grey,
        ),
        "td": Style(
          padding: EdgeInsets.all(6),
          alignment: Alignment.topLeft,
        ),
        'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
      },
      onLinkTap: (url, _, __, ___) {
        print("Opening $url...");
      },
      onImageTap: (src, _, __, ___) {
        print(src);
      },
      onImageError: (exception, stackTrace) {
        print(exception);
      },
      onCssParseError: (css, messages) {
        print("css that errored: $css");
        print("error messages:");
        messages.forEach((element) {
          print(element);
        });
      },
    );
  }
}