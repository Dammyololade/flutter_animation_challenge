import 'package:flutter/material.dart';
import 'package:flutter_challenge/placeModel.dart';

import 'landing_page_screen.dart';

/// description:
/// project: flutter_challenge
/// @package: 
/// @author: dammyololade
/// created on: 22/08/2020
class DetailsPage extends StatefulWidget {

  PlaceModel model;
  DetailsPage(this.model);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  PlaceModel get model => widget.model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.model.bgColor.withOpacity(.9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 200,
            flexibleSpace: Container(
              height: 300,
              child: Hero(
                tag: model.image,
                child: Material(
                  type: MaterialType.transparency,
                  child: Stack(
                    children: [
                      Image.asset(
                        "images/${model.image}",
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.black26,
                      ),
                      Positioned(
                          top: 50,
                          left: 50,
                          right: 40,
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
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "New York",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30
                                                ),
                                              ),
                                            ),
                                          ],
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
                                  //Spacer(),
                                  Icon(Icons.flight_takeoff, size: 60, color: Colors.white,)
                                ],
                              ),

                              Spacer(),

                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Empire stato",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
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
            actions: [
              IconButton(icon: Icon(Icons.menu, color: Colors.white70,), onPressed: () {  },)
            ],
          ),

          SliverToBoxAdapter(
            child: Hero(
              tag: "${model.image}_container",
              child: Container(
                height: 500,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: PageCardDesign(model),
              ),
            ),
          )
        ],
      ),
    );
  }
}
