import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news_app/helpers/constants.dart';

import '../widgets/MenuWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 200 - 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: myPrimaryColor,
                    // borderRadius: BorderRadius.only(
                    //   bottomLeft: Radius.circular(30),
                    //   bottomRight: Radius.circular(30),
                    // ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    // color: Colors.red,
                    height: 150,
                    width: size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        MenuWidget(),
                        MenuWidget(),
                        MenuWidget(),
                        MenuWidget(),
                        SizedBox(width: 30),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: size.width,
              height: 500,
              // color: Colors.white,
              child: SingleChildScrollView(
                child: Column(children: const [
                  Text("HELLO"),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
