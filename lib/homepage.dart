import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:qoutes/business/model.dart';
import 'package:qoutes/business/services.dart';
import 'package:qoutes/completedPAge.dart';
import 'package:qoutes/resources.dart';
import 'package:qoutes/styles.dart';
import 'package:lottie/lottie.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

class Homepage extends StatefulWidget {
  final int selected;
  Homepage({Key key, this.selected}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _drawerController = ZoomDrawerController();
  ScreenshotController screenshotController = ScreenshotController();
  int selected = 0;
  Color currentColor = Resourses.colors[0];
  List<Article> articles = [];

  int currentPageIndex = 0;

  List<Widget> pages = [];
  bool isvisible = false;
  bool isShareVisible = false;
  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? 0;
    _generatePages();
  }

  _onShare() async {
    screenshotController.capture(pixelRatio: 2).then((val) {
      // File image = File.fromRawPath(val);
      return Share.shareFiles([val.path],
              text: 'Checkout this latest news from #minfo')
          .whenComplete(() {
        setState(() {
          isShareVisible = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: _buildMenu(),
      borderRadius: 24.0,
      showShadow: true,
      isRtl: true,
      angle: -12,
      backgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width * .39,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.easeInBack,
      mainScreen: Scaffold(
        backgroundColor: white2,
        floatingActionButton: isvisible
            ? Container()
            : Container(
                height: 65,
                width: 65,
                child: LiquidCircularProgressIndicator(
                  value: currentPageIndex / (articles.length - 1),
                  valueColor: AlwaysStoppedAnimation(orange2),
                  backgroundColor: white2,
                  direction: Axis.vertical,
                  center: FloatingActionButton(
                      heroTag: "complete",
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      onPressed: () {
                        _drawerController.toggle();
                        setState(() {
                          isvisible = !isvisible;
                        });
                        // open side menu
                      },
                      child: Icon(
                        LineIcons.compass,
                        color: black,
                        size: 32,
                      )),
                ),
              ),
        body: pages.isNotEmpty
            ? Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onDoubleTap: () {
                        print("dtap");
                        setState(() {
                          isShareVisible = true;
                        });
                        Future.delayed(Duration(seconds: 2), () {
                          _onShare();
                        });
                      },
                      child: Screenshot(
                        controller: screenshotController,
                        child: LiquidSwipe(
                            enableLoop: false,
                            waveType: WaveType.liquidReveal,
                            fullTransitionValue: 300,
                            initialPage: 0,
                            onPageChangeCallback: (i) {
                              setState(() {
                                currentPageIndex = i;
                              });
                              if (currentPageIndex == articles.length)
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CompletedPage(
                                              wasSelected: selected,
                                            )));
                            },
                            pages: pages),
                      ),
                    ),
                  ),
                  isShareVisible
                      ? Positioned.fill(
                          child: Center(
                            child: Container(
                              color: white2.withOpacity(0.1),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: white2.withOpacity(0.1),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  isShareVisible
                      ? Positioned.fill(
                          child: Center(
                            child: Container(
                                height: 100,
                                width: 100,
                                child: Lottie.asset('assets/send1.json',
                                    repeat: true)),
                          ),
                        )
                      : Container()
                ],
              )
            : Center(
                child: Container(
                    height: 80,
                    width: 80,
                    child: Lottie.asset('assets/butterfly-loader.json',
                        repeat: true)),
              ),
      ),
    );
  }

  _buildMenu() {
    return Material(
      color: white2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...List.generate(
                  Resourses.catList.length,
                  (index) => ListTile(
                        onTap: () {
                          _drawerController.toggle();
                          setState(() {
                            selected = index;
                            pages = [];
                            isvisible = !isvisible;
                            _generatePages();
                          });
                        },
                        title: Text(
                          Resourses.catList[index].toUpperCase(),
                          textAlign: TextAlign.end,
                          style: subtitle1.copyWith(color: black),
                        ),
                        dense: true,
                        trailing: Icon(
                          Resourses.iconsList[index],
                          color: black,
                        ),
                      )),
              InkWell(
                onTap: () {
                  _drawerController.toggle();
                  setState(() {
                    isvisible = !isvisible;
                  });
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
    );
  }

  _generatePages() async {
    articles =
        await NewsServices.getNewsFromKeyword(Resourses.keywordList[selected]);
    pages = getPageWidgets();
    setState(() {});
  }

  List<Widget> getPageWidgets() {
    Random random = Random();
    int r = 0, x;
    return List.generate(articles.length + 1, (index) {
      do {
        x = random.nextInt(Resourses.colors.length);
      } while (x == r);
      r = x;
      return buildSinglePage(
          color: Resourses.colors[x],
          article: articles[index == articles.length ? 0 : index]);
    });
  }

  buildSinglePage({Color color, Article article}) {
    double initialHeight = 50;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0,
        leading: Icon(
          LineIcons.safari,
          color: Colors.transparent,
        ),
        actions: [
          IconButton(
            icon: Icon(LineIcons.share),
            onPressed: () {
              print("dtap");
              setState(() {
                isShareVisible = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                _onShare();
              });
            },
          )
        ],
        title: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: white2,
            ),
            child: Text(
              Resourses.catList[selected].toUpperCase(),
              style: headline2.copyWith(color: black, fontSize: 18),
            ),
          ),
        ),
      ),
      body: Container(
        color: color,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 28),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: Offset(10, 10),
                        color: black.withOpacity(0.4),
                        blurRadius: 15)
                  ]),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        color: white2,
                        height: initialHeight,
                        child: Image.network(
                          article.imageUrl,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              initialHeight =
                                  MediaQuery.of(context).size.width * 0.6;
                              return child;
                            }
                            return Container(
                              child: Center(
                                  child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              )),
                            );
                          },
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                article.title,
                style: headline.copyWith(
                    color: color.computeLuminance() > 0.5 ? black : white),
              ),
              Text(
                article.content,
                style: body1.copyWith(
                    color: color.computeLuminance() > 0.5 ? black : white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
