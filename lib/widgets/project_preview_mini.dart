import 'package:flutter/material.dart';
import 'package:RDSH/rdsh_icons_icons.dart';


class ProjectPreviewMini extends StatefulWidget {
  String? title;
  String? date;
  Widget? image;
  Widget? tags;
  Color? colorFont;
  
  ProjectPreviewMini({Key? key, this.title, this.image, this.tags, this.colorFont, this.date}) : super(key: key);

  @override
  _ProjectPreviewMini createState() => _ProjectPreviewMini();
}

class _ProjectPreviewMini extends State<ProjectPreviewMini> {

  @override
  initState() {
    
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          fit: StackFit.passthrough,
          children:[
            Container(
              width: 210,
              height: 122,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                child: widget.image,
              )
            ),
            Positioned(
              bottom: 14, 
              left: 14, 
              child: widget.tags!,
            ),
          ]
        ),
        Container(
          width: 210,
          height: 110,
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 14, left: 14, right: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title!, maxLines: 3, textAlign: TextAlign.left, style: theme.textTheme.bodyText1?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                )),
                Container(height: 10),
                Text(widget.date!, maxLines: 1, style: theme.textTheme.overline?.copyWith(
                  color: theme.colorScheme.onBackground,
                )),
              ]
            ),
          ),
        ),
      ]
    );
  }
}