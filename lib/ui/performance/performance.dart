import 'package:employee/custview/Divider.dart';
import 'package:employee/custview/material_segmented_control.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  int _currentSelection = 0;

  Map<int, Widget> _children() => {
        0: Text('当日绩效'),
        1: Text('月度绩效'),
      };

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("绩效"),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            //分段菜单
            children: <Widget>[
              //分段菜单
              new Padding(
                  padding: EdgeInsets.only(left: 2, top: 24, right: 2),
                  child: Container(
                    width: double.maxFinite,
                    child: MaterialSegmentedControl(
                      children: _children(),
                      selectionIndex: _currentSelection,
                      borderColor: Colors.grey,
                      selectedColor: Colors.blueAccent,
                      unselectedColor: Colors.white,
                      borderRadius: 32.0,
                      onSegmentChosen: (index) {
                        setState(() {
                          _currentSelection = index;
                        });
                      },
                    ),
                  )),

              //个人绩效
              new Padding(
                padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                child: Container(

                  width: double.maxFinite,
                  child: Card(
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    //设置圆角
                    child: Column(
                      children: <Widget>[
                        //one
                        new Padding(
                          padding: EdgeInsets.only(top: 5, right: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "我的绩效",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                "查看考核标准",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blueAccent),
                              )
                            ],
                          ),
                        ),

                        //分割线
                        new Padding(
                          padding: EdgeInsets.only(top: 5, right: 5, left: 5,bottom: 10),
                          child: DividerLine(),
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                DUText("2019年07月", "14日"),
                                DUText("我的积分", "暂无"),
                                DUText("我的排名", "暂无")
                                
                                
                                
                              ],
                            ),
                            new Padding(padding: EdgeInsets.only(top: 10,left: 10,bottom: 10),child: Text("我的上级:暂无"),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

//文字上下排列的小部件

class DUText extends StatelessWidget {
  var title;
  var data;

  DUText(this.title, this.data);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(title,style: TextStyle(fontSize: 16),),
        new Padding(padding: EdgeInsets.only(top: 10),
          child: Text(data,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w600 ),),)
      ],
    );;
  }
}


