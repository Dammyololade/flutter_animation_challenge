import 'package:flutter/material.dart';
import 'package:flutter_challenge/PageViewHolder.dart';
import 'package:flutter_challenge/detail_page.dart';
import 'package:flutter_challenge/placeModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';

///
/// project: flutter_challenge
/// @package:
/// @author dammyololade
/// created on 21/08/2020

class LandingPageScreen extends StatefulWidget {
  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  var fraction = 0.80;
  PageController _controller;
  List<PlaceModel> places;
  PageViewHolder _holder;
  List<Color> _colors;
  ValueNotifier<int> pageChangeNotifier = ValueNotifier(2);

  Duration animationDuration = Duration(seconds: 1);

  @override
  void initState() {
    _colors = [
      Color(0xff432C2F),
      Color(0xff1E382A),
      Color(0xff3B3B3B),
      Color(0xff325D50),
      Color(0xff5B371B),
      Color(0xff263D20),
      Color(0xff3A1C2B),
      Color(0xff242336),
    ];

    super.initState();
    _holder = PageViewHolder(value: 2.0);
    _controller = PageController(initialPage: 2, viewportFraction: fraction);
    places = List<PlaceModel>.generate(
      8,
      (index) => PlaceModel(
          "image_${index + 1}.jpg",
          "The Eiffel tower",
          "Paris",
          "470USD",
          "Terenese band studio",
          Reporter("", "Luke Fries", "Terenese band studio", "Out-of-box-bound",
              "Lorem ipsum", "", DateTime.now()),
          _colors[index],
          index + 1),
    );
    _controller.addListener(() {
      pageChangeNotifier.value = _controller.page.toInt();
      _holder.setValue(_controller.page);
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: pageChangeNotifier,
          builder: (_, int value, __) => AnimatedContainer(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: _colors[value]),
            duration: animationDuration,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(.3)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white.withOpacity(.5),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                "Search places",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(.5),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.settings_input_composite,
                      color: Colors.white.withOpacity(.3),

                    ),
                  ],
                ),
              ),
              Expanded(
                child: ChangeNotifierProvider<PageViewHolder>.value(
                  value: _holder,
                  child: PageView.builder(
                      controller: _controller,
                      physics: BouncingScrollPhysics(),
                      pageSnapping: true,
                      itemCount: places.length,
                      itemBuilder: (ct, index) {
                        return PlacePage(index.toDouble(), places[index]);
                      }),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 320,
          left: 0,
          right: 0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: pageChangeNotifier,
                builder: (_, int value, __) => Container(
                  height: 30,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: places.length,
                      itemBuilder: (c, index) => AnimatedContainer(
                        height: 10,
                        width: 10,
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: value == index ? Border.all(color: Colors.white) : Border()
                        ),
                        duration: animationDuration,
                        child: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                              shape: BoxShape.circle,
                          ),
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlacePage extends StatelessWidget {
  final double number;

  PlaceModel model;

  PlacePage(this.number, this.model);

  @override
  Widget build(BuildContext context) {
    double value = Provider.of<PageViewHolder>(context).value;
    double diff = (number - value);
    final matrix = Matrix4.identity()
      ..setEntry(3, 3, 1) // increase scale by 90
      ..setEntry(1, 1, 1) // changing scale along Y azis
      ..setEntry(3, 0, 0.0005 * -diff); // changing perspective along x axis

//    final matrix = Matrix4.identity()
//      ..setEntry(3, 3, 1 / 0.9) // increase scale by 90
//      ..setEntry(1, 1, fraction) // changing scale along Y azis
//      ..setEntry(3, 0, 0.004 * -diff); // changing perspective along x axis

    //matrix for shadow
//    final shadowMatrix = Matrix4.identity()
//      ..setEntry(3, 3, 1 / 1.6) // increase scale by 90
//      ..setEntry(1, 1, -0.004) // changing scale along Y axis
//      ..setEntry(3, 0, 0.002 * diff) // changing perspective along x axis
//      ..rotateX(1.309); // rotating shadow along x axis

    return Transform(
      transform: matrix,
      alignment: FractionalOffset.center,
      child: GestureDetector(
        onVerticalDragStart: (hh) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DetailsPage(model)));
        },
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Hero(
                tag: model.image,
                child: Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                                image: AssetImage(
                                    "images/image_${number.toInt() + 1}.jpg"),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.black26,
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        right: 20,
                        bottom: 15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "New York",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        ),
                                      ),

                                      Text(
                                        "470USD",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Icon(Icons.flight_takeoff, size: 60, color: Colors.white,)
                              ],
                            ),

                            Spacer(),

                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text("Empire stato",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Text("22/09/2020",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Text("Check-in",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Hero(
                    tag: "${model.image}_container",
                    child: PageCardDesign(model)))
          ],
        ),
      ),
    );
  }
}

class PageCardDesign extends StatelessWidget {
  PlaceModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/face_${model.index}.jpg"),
                  radius: 30,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: "${model.reporter.name}",
                          style: TextStyle(
                              fontFamily: "Roboto sans",
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: "  shared a comment",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "07:00",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: " am",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26),
                            ),
                            TextSpan(
                              text: "    March 7, 2010",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black26),
                            )
                          ]),
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${model.reporter.title}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff474850)),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "${model.reporter.subtitle}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xffB0B2B5)),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Contrary to popular belief, Lorem Ipsum is not simply "
              "random text. It has roots in a piece of classical Latin "
              "literature from 45 BC, making it over 2000 years old. "
              "Richard McClintock",
              style: TextStyle(fontSize: 12, color: Color(0xffB0B2B5)),
              maxLines: 3,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
              //margin: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: AssetImage("images/details_${model.index}.jpg"),
                    fit: BoxFit.cover,
                  )),
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.grey,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "SHARE",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.withOpacity(.5),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset(
                  "images/facebook.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset(
                  "images/twitter.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset(
                  "images/github.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset(
                  "images/linkdn.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset(
                  "images/google.png",
                  width: 20,
                  height: 20,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  PageCardDesign(this.model);
}
