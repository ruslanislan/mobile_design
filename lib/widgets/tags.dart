import 'package:flutter/material.dart';
import 'package:RDSH/rdsh_icons_icons.dart';

class Tag {
  Widget? icon;
  String? label;
  Tag({this.icon, this.label});
}

class Tags extends StatefulWidget {
  List<Tag>? items;
  Color? backgroundColor;
  Color? color;
  
  Tags({Key? key, this.items, this.backgroundColor, this.color}) : super(key: key);

  @override
  _Tags createState() => _Tags();
}

class _Tags extends State<Tags> {

  @override
  initState() {
    widget.backgroundColor = widget.backgroundColor != null ? widget.backgroundColor : Color(0xff595A5B).withOpacity(0.95);
    widget.color = widget.color != null ? widget.color : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: 190,
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          ...widget.items!.map((tag) => 
            Container(
              height: 30,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: 
                  tag.icon != null ? 
                    [
                      tag.icon!,
                      Container(width: 5),
                      Text(tag.label!, 
                        style: theme.textTheme.overline?.copyWith(
                          color: widget.color,
                        ),
                      ),
                    ] : 
                    [
                      Text(tag.label!, 
                        style: theme.textTheme.overline?.copyWith(
                          color: widget.color,
                        ),
                      ),
                    ]
              ),
            )
          ).toList(),
        ]
      ),
    );
  }
}