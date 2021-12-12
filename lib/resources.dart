import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class Resourses {
  static List<String> catList = [
    'trending',
    'national', //I,ndian News only
    'business',
    'sports',
    'world',
    'politics',
    'technology',
    'startup',
    'entertainment',
    'miscellaneous',
    'hatke',
    'science',
    'automobile',
  ];
  static List<String> keywordList = [
    'all',
    'national', //I,ndian News only
    'business',
    'sports',
    'world',
    'politics',
    'technology',
    'startup',
    'entertainment',
    'miscellaneous',
    'hatke',
    'science',
    'automobile',
  ];
  static List<IconData> iconsList = [
    LineIcons.newspaper,
    LineIcons.mapMarker,
    LineIcons.briefcase,
    LineIcons.futbol,
    LineIcons.globe,
    LineIcons.bullhorn,
    LineIcons.laptop,
    LineIcons.building,
    LineIcons.video,
    LineIcons.paperclip,
    LineIcons.angellist,
    LineIcons.flask,
    LineIcons.car
  ];
  static List<Color> colors = [
    Color(0xff845ec2),
    Color(0xffff5e78),
    Color(0xff008891),
    Color(0xff008891),
    Color(0xff845ec2),
    Color(0xff55c59d),
    Color(0xffee5a5a),
    Color(0xffb31e6f),
    Color(0xff397c4f),
    Color(0xff7c3945),
    Color(0xffec4343),
  ];
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 1500);

  CustomPageRoute({builder}) : super(builder: builder);
}
