import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:RDSH/rdsh_icons_icons.dart';
import 'package:RDSH/models/status.dart';

class Task extends StatelessWidget {
  
  String _title = '';
  String? _status;
  String? _date;
  // Function()? _func;
  
  Task(String title, {String? status, String? date}) {
    _title = title;
    _status = status;
    _date = date;
  }

  Widget _getTextWidgetByStatus(BuildContext context, String? status) {
    final ThemeData theme = Theme.of(context);
    if (status == 'success') {
      return Text('Задание выполнено'.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, fontFamily: 'SF Pro Text', color: Color(0xff26D370)));
    }
    if (status == 'canceled') {
      return Text('Задание отменено'.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, fontFamily: 'SF Pro Text', color: Color(0xffD12D17)));
    }
    if (status == 'wait') {
      return Text('На рассмотрении'.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, fontFamily: 'SF Pro Text', color: theme.colorScheme.onBackground));
    }
    return Text('до ${_date!}', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, fontFamily: 'SF Pro Text', color: theme.colorScheme.onBackground));
  }

  Widget _getSubtitle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _getTextWidgetByStatus(context, _status),
        Container(width: 10),
        Icon(Icons.flash_on, size: 12, color: theme.colorScheme.onBackground),
        Text('70', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, fontFamily: 'SF Pro Text', color: theme.colorScheme.onBackground)),
      ]
    );
  }

  Widget? _getIconStatus(BuildContext context, String? status) {
    final ThemeData theme = Theme.of(context);
    if (status == 'success') {
      return Container(
        width: 18,
        height: 18,
        child: Icon(RdshIcons.success, color: Color(0xff26D370), size: 18),
      );
    }
    if (status == 'canceled') {
      return Container(
        width: 18,
        height: 18,
        child: Icon(RdshIcons.error, color: Color(0xffD12D17), size: 18),
      );
    }
    if (status == 'wait') {
      return Container(
        width: 18,
        height: 18,
        child: CupertinoActivityIndicator(
          radius: 7,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Icon(RdshIcons.camera, color: theme.colorScheme.primary, size: 20),
                ),
              ),
              
              Positioned(
                bottom: 0,
                right: 0,
                child: _getIconStatus(context, _status) ?? Container(),
              ),
            ]
          ),
          Container(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_title, maxLines: 2, textAlign: TextAlign.left, style: theme.textTheme.bodyText1?.copyWith(
                  decoration: _status == 'success' ? TextDecoration.lineThrough : null,
                  color: theme.colorScheme.secondary,
                )),
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: _getSubtitle(context)
                ),
              ],
            ),
          ),
        ] 
      ),
    );
  }
}

// ListTile(
//         visualDensity: VisualDensity(vertical: -4),
//         dense:true,
//         contentPadding: EdgeInsets.only(left: 0, bottom: 0, top: 0),
//         horizontalTitleGap: 20,
//         minLeadingWidth: 0,
//         minVerticalPadding: 0,
        // leading: 
        // title: 
//         subtitle: _getSubtitle(context),
//       ),