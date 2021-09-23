import 'package:flutter/material.dart';
import 'package:RDSH/widgets/button_link.dart';

class Description extends StatefulWidget {
  String? title;
  String? desc;
  bool? withButtonMore;
  
  Description({Key? key, this.title, this.desc, this.withButtonMore = false}) : super(key: key);

  @override
  _Description createState() => _Description();
}

class _Description extends State<Description> {

  @override
  initState() {
    
  }

  bool? _isHide = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title!, 
          textAlign: TextAlign.left,
          style: theme.textTheme.headline3?.copyWith(
            color: theme.colorScheme.secondary
        )),
        Container(height: 10),
        Text(widget.desc!, 
          textAlign: TextAlign.left,
          maxLines: _isHide! ? 9 : null,
          style: theme.textTheme.bodyText2?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w400,
        )),
        widget.withButtonMore! ? 
          ButtonLink(
            _isHide! ? 'Раскрыть полное описание' : 'Скрыть описание',
            () => {
              setState(() => _isHide = !_isHide!)
            },
            type: 'link',
            isCover: false,
            // height: 18,
          ) :
          Container(), 
      ]
    );
  }
}