import 'dart:math';

import 'package:employee/bean/performance/CustView.dart';
import 'package:flutter/material.dart';


class MinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text("我的"),
        centerTitle: true,
      ),
      body: MyAnimate(),
    );
  }
}


class MyAnimate extends StatefulWidget{
  double width;

  var first=true;


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAnimateState();
  }

}
class MyAnimateState extends State<MyAnimate> with SingleTickerProviderStateMixin{
  AnimationController animationController;

  Animation<double> animate;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 5000));
       animate = Tween(begin: 0.0,end: 400.0).animate(animationController);
      animationController.addListener((){
        setState(() {

        });
      });
      animationController.repeat();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.translate(offset: Offset(0, animate.value),child: FlutterLogo(),);

  }

}

