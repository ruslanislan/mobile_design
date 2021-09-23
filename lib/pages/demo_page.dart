import 'package:RDSH/widgets/button.dart';
import 'package:RDSH/widgets/button_link.dart';
import 'package:flutter/material.dart';
import 'package:RDSH/widgets/input.dart';
import 'package:RDSH/rdsh_icons_icons.dart';
import 'package:RDSH/cache.dart' as cache;

class DemoPageWidget extends StatefulWidget {
  @override
  _DemoPageWidget createState() => _DemoPageWidget();
}

class _DemoPageWidget extends State<DemoPageWidget> {

  final _formKey = GlobalKey<FormState>();

  @override
  initState() {

  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: Text(
          '',
          style: theme.textTheme.headline3?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
        leading: IconButton(
          icon: Icon(RdshIcons.back, color: theme.colorScheme.primary, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Color(0xfff2f2f2),
        titleSpacing: 14,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 14, right: 14, top: 5),
        child: Container(),
      ),
    );
  }
}