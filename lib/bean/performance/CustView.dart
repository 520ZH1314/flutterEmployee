

import 'dart:ui';

import 'package:flutter/material.dart';

class BackGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // 使用CustomPaint
        child: CustomPaint(
          size: Size(300, 300),
          painter: MyTextPanit(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 30;
    double eHeight = size.height / 30;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Color(0xFF888888)
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 30; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 30; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    var _paint = Paint()
      ..color = Color(0xFFFf0000)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    List<Offset> points = [
      Offset(0, 0),
      Offset(30, 50),
      Offset(20, 80),
      Offset(100, 40),
      Offset(150, 90),
      Offset(60, 110),
      Offset(260, 160),
    ];
    canvas.drawPoints(PointMode.points, points, _paint);




  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>   oldDelegate != this;
}

class  MyTextPanit extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
     double  height =size.height;
     double  width =size.width;

     //画笔
    var  mPaint  =Paint()
        ..color=Colors.blueAccent
        ..isAntiAlias = true;


    canvas.drawRect(Rect.fromCenter(center: Offset(height/2, height/2),width: width,height: height), mPaint);
    mPaint
     ..color=Colors.white;

    //竖线
     for(int i=0;i<30;i++){
       canvas.drawLine(Offset(i*10.0, 0), Offset(i*10.0, height), mPaint) ;
     }
     //横线
     for(int i=0;i<30;i++){
       canvas.drawLine(Offset(0, i*10.0), Offset(height, i*10.0), mPaint) ;
     }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate!=this;
  }

}

