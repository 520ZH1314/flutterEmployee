import 'package:employee/ui/boss/Boss.dart';
import 'package:employee/ui/mine/mine.dart';
import 'package:employee/ui/performance/performance.dart';
import 'package:employee/ui/team/team.dart';
import 'package:flutter/material.dart';

//主界面

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  //初始化Index

  int _Index=0;

  //初始化容器

  List<Widget> _Pages=[new PerformancePage(),new TeamPage(),new BossPage(),new MinePage()];


   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: IndexedStack(
           children: _Pages,
           index: _Index,
      ),
      bottomNavigationBar: _initBottomBar(),
    );
  }



  //获取底部的四个按钮
  BottomNavigationBar _initBottomBar()  {

    return   new BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
            icon: ImageIcon( new AssetImage("images/performance.png")), title: new Text("绩效")),
        new BottomNavigationBarItem(
            icon: ImageIcon( new AssetImage("images/team.png")), title: new Text("园地")),
        new BottomNavigationBarItem(
            icon: ImageIcon( new AssetImage("images/boss.png")), title: new Text("招聘")),
        new BottomNavigationBarItem(
            icon: ImageIcon( new AssetImage("images/mine.png")), title: new Text("我的")),
      ],
      type: BottomNavigationBarType.fixed,
      //默认选中首页
      currentIndex: _Index,
      iconSize: 24.0,
      //点击事件
      onTap: (index) {
        setState(() {
          _Index = index;
        });
      },
    );




  }
}


