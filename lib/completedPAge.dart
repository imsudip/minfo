import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:qoutes/homepage.dart';
import 'package:qoutes/resources.dart';
import 'package:qoutes/styles.dart';

class CompletedPage extends StatefulWidget {
  final int wasSelected;
  CompletedPage({Key key, this.wasSelected}) : super(key: key);

  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final _drawerController = ZoomDrawerController();
  bool visible = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'complete',
      child: Container(
        child: ZoomDrawer(
          controller: _drawerController,
          menuScreen: buildMenu(),
          borderRadius: 24.0,
          showShadow: true,
          angle: -3,
          slideWidth: MediaQuery.of(context).size.width * -.39,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.easeInBack,
          mainScreen: Scaffold(
              backgroundColor: white2,
              body: Container(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: visible
                          ? Lottie.asset('assets/confetti.json', repeat: false)
                          : Container(),
                    ),
                    Positioned(
                      top: 80,
                      left: 20,
                      right: 20,
                      child:
                          Lottie.asset('assets/complete.json', repeat: false),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.3,
                      left: 20,
                      right: 20,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Thats all for ${Resourses.catList[widget.wasSelected]}",
                              textAlign: TextAlign.center,
                              style:
                                  headline.copyWith(color: Color(0xffEB5948)),
                            ),
                            Text("Checkout other Interests!",
                                style: subtitle1.copyWith(
                                    color: Color(0xffEB5948))),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.2,
                      left: 20,
                      right: 20,
                      child: FlatButton(
                        onPressed: () {
                          _drawerController.toggle();
                        },
                        minWidth: 200,
                        height: 45,
                        color: Color(0xffEB5948),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Explore Other Sections ",
                              style: subtitle1,
                            ),
                            Icon(
                              LineIcons.arrowRight,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              )),
        ),
      ),
    );
  }

  buildMenu() {
    return Material(
      color: white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...List.generate(
                    Resourses.catList.length,
                    (index) => ListTile(
                          tileColor: widget.wasSelected != null &&
                                  widget.wasSelected == index
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.transparent,
                          onTap: () {
                            _drawerController.toggle();
                            Navigator.pushReplacement(
                                context,
                                CustomPageRoute(
                                    builder: (context) => Homepage(
                                          selected: index,
                                        )));
                          },
                          title: Text(
                            Resourses.catList[index].toUpperCase(),
                            textAlign: TextAlign.end,
                            style: subtitle1.copyWith(color: black),
                          ),
                          trailing: Icon(
                            Resourses.iconsList[index],
                            color: black,
                          ),
                        )),
                InkWell(
                  onTap: () {
                    _drawerController.toggle();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.orange),
                    child: Icon(LineIcons.times),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
