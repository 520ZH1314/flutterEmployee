
import 'package:employee/bean/performance/CustView.dart';
import 'package:employee/bean/performance/PostIsLeaderBean.dart';
import 'package:employee/http/Api.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/bloc/UserBloc.dart';
import 'package:employee/ui/boss/Boss.dart';
import 'package:employee/ui/mine/mine.dart';
import 'package:employee/ui/performance/performance.dart';
import 'package:employee/ui/team/team.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

//主界面

class HomePage extends StatefulWidget {

  HomePage(){

    PostIsLeaderBean postIsLeaderBean= PostIsLeaderBean(ApiCode:"GetTeamIDAndLeader",AppCode:"EMS",
        TenantId:"00000000-0000-0000-0000-000000000001" ,UserId: "7565acc5-8025-11e8-b8e8-507b9d9a63b9"
    );
    userBloc.executeLogin(postIsLeaderBean);
    userBloc.subject.listen((data){
      if(data.status==Status.SUCCESS){
        if(data.data.rows!=null){
          SpUtil.putBool(Api.TEAMLEADER,data.data.rows[0].isTeamLeader);
          SpUtil.putString(Api.TEAMID,data.data.rows[0].teamId);
          SpUtil.putString(Api.TEAMLEADERNAME,data.data.rows[0].teamLeaderUserName);
        }

      }

    });

  }


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  //初始化Index

  int _Index=0;

  //初始化容器

  List<Widget> _Pages=[new PerformancePage(),new BackGrid(),new BossPage(),new MinePage()];


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


