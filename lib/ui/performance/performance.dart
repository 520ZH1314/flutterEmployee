
import 'package:employee/bean/performance/YesTerDayPostBean.dart';
import 'package:employee/bean/performance/month_data_post_bean.dart';
import 'package:employee/custview/Divider.dart';
import 'package:employee/custview/material_segmented_control.dart';
import 'package:employee/http/Api.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/bloc/UserBloc.dart';
import 'package:flustars/flustars.dart';
import 'package:employee/bean/performance/yester_day_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:progress_hud/progress_hud.dart';


class PerformancePage extends StatefulWidget {
  @override
  _PerformancePageState createState() => _PerformancePageState();

}

class _PerformancePageState extends State<PerformancePage> {
  int _currentSelection = 0;


  DateTime dateTime;

  List<String> split; //昨日的时间
  List<String> monthSplit;

  String teamId;

  List<YesterDayRowsReturndayinfoUserinfo> userInfo;

  List<YesterDayRowsReturndayinfoTopteaminfo> topTeamInfo;


  Map<int, Widget> _children() => {
        0: Text('当日绩效'),
        1: Text('月度绩效'),
      };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    teamId = SpUtil.getString(Api.TEAMID);
    //初始化日期
    dateTime = DateTime.now();
    String formatDate = DateUtil.formatDate(dateTime, format: "yyyy-MM-dd");
    YesTerDayPostBean  bean =YesTerDayPostBean(TenantId:Api.TenantId ,AppCode:"EMS",ApiCode:"GetUserInfoOfDay" ,ShiftDate:formatDate ,TeamId:teamId ,UserCode:Api.UserCode );
     userBloc.getYesterDayData(bean);
    split = formatDate.split("-");
    monthSplit = List();
    monthSplit.add(split[0]);
    monthSplit.add(split[1]);
    MonthDataPostBean  monthDataPostBean =new  MonthDataPostBean(UserCode:Api.UserCode ,TeamId: teamId,ShiftDate:split[0]+"-"+split[1]+"-"+"01" ,ApiCode:"GetUserInfoOfMonth" ,AppCode:"EMS" ,TenantId:Api.TenantId );
    userBloc.getMonthData(monthDataPostBean);
  }



  @override
  Widget build(BuildContext context) {

    if( _currentSelection==0){
      return  StreamBuilder<ApiResponse<YesterDayEntity>>(
          stream: userBloc.mYesterDayEntityEntity.stream,
          builder: (context, AsyncSnapshot<ApiResponse<YesterDayEntity>> response) {


            if(response.data.status==Status.LOADING){

              return new Scaffold(
                  appBar: AppBar(
                    title: Text("绩效"),
                    centerTitle: true,
                  ),
                  body: new ProgressHUD(
                    backgroundColor: Colors.black12,
                    color: Colors.white,
                    containerColor: Colors.blue,
                    borderRadius: 5.0,
                    text: 'Loading...',
                  )

              );

            }else if(response.data.status==Status.SUCCESS){
              if(  response.data.data.rows!=null){
                userInfo = response.data.data.rows[0].returndayInfo.userInfo;

              }
              if(  response.data.data.rows!=null){
                topTeamInfo = response.data.data.rows[0].returndayInfo.topTeamInfo;
              }
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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(7.0))),
                              //设置圆角
                              child: Column(
                                children: <Widget>[
                                  //one
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "我的绩效",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 17, color: Colors.black),
                                        ),
                                        Text(
                                          "查看考核标准",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 16,
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                  ),

                                  //分割线
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 5, left: 5, bottom: 10),
                                    child: DividerLine(),
                                  ),
                                  new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              _getTime(context);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _currentSelection == 0
                                                      ? split[0] +
                                                      "年" +
                                                      split[1] +
                                                      "月"
                                                      : monthSplit[0] + "年",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                new Padding(
                                                  padding:
                                                  EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    _currentSelection == 0
                                                        ? split[2] + "日"
                                                        : monthSplit[1] + "月",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.blueAccent),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          DUText("我的积分" ,  userInfo.length!=0?userInfo[0].score.toString(): "暂无"),
                                          DUText( "我的排名" ,  userInfo.length!=0?userInfo[0].seq.toString(): "暂无")
                                        ],
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, bottom: 10),
                                        child: Text( userInfo.length!=0?"我的上级:"+userInfo[0].teamLeaderName:"我的上级:暂无"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        //班组绩效
                        new Padding(
                          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Container(
                            child: Card(
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(7.0))),
                              child: Column(
                                children: <Widget>[
                                  //title
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "班组绩效",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 18, color: Colors.black),
                                        ),
                                        Text(
                                          "排名",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 16,
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                  ),
                                  //分割线
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 5, left: 5, bottom: 10),
                                    child: DividerLine(),
                                  ),

                                  Container(
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(

                                            child: new Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "优秀",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[

                                                          Text("姓名"),


                                                          Text("积分"),

                                                          Text("排名"),

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),

                                                          Image.asset("images/icon_no_1.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),

                                                          Image.asset("images/icon_no_2.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),


                                                          Image.asset("images/icon_no_3.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            )),

                                        ColumDividerLine(),


                                        Expanded(

                                            child: new Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "加油",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[

                                                          Text("姓名"),


                                                          Text("积分"),

                                                          Text("排名"),

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
                                                          Image.asset("images/icon_no_1.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
                                                          Image.asset("images/icon_no_2.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三",style: TextStyle(fontFamily: "HanaleiFill",)),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),


                                                          Image.asset("images/icon_no_3.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));

            }else{
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
//                     new Padding(
//                       padding: EdgeInsets.only(top: 10, left: 5, right: 5),
//                       child: Container(
//                         width: double.maxFinite,
//                         child: Card(
//                           elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(7.0))),
//                           //设置圆角
//                           child: Column(
//                             children: <Widget>[
//                               //one
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 10, left: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Text(
//                                       "我的绩效",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 17, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "查看考核标准",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 16,
//                                           color: Colors.blueAccent),
//                                     )
//                                   ],
//                                 ),
//                               ),
//
//                               //分割线
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 5, left: 5, bottom: 10),
//                                 child: DividerLine(),
//                               ),
//                               new Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                     children: <Widget>[
//                                       GestureDetector(
//                                         onTap: () {
//                                           _getTime(context);
//                                         },
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Text(
//                                               _currentSelection == 0
//                                                   ? split[0] +
//                                                   "年" +
//                                                   split[1] +
//                                                   "月"
//                                                   : monthSplit[0] + "年",
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             new Padding(
//                                               padding:
//                                               EdgeInsets.only(top: 10),
//                                               child: Text(
//                                                 _currentSelection == 0
//                                                     ? split[2] + "日"
//                                                     : monthSplit[1] + "月",
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                     FontWeight.w600,
//                                                     color: Colors.blueAccent),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       DUText(
//                                           _currentSelection == 0
//                                               ? "我的积分"
//                                               : "累计积分",
//                                           "暂无"),
//                                       DUText(
//                                           _currentSelection == 0
//                                               ? "我的排名"
//                                               : "累计积分排名",
//                                           "暂无")
//                                     ],
//                                   ),
//                                   new Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 10, left: 10, bottom: 10),
//                                     child: Text("我的上级:暂无"),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     //班组绩效
//                     new Padding(
//                       padding: EdgeInsets.only(top: 5, left: 5, right: 5),
//                       child: Container(
//                         child: Card(
//                           elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(7.0))),
//                           child: Column(
//                             children: <Widget>[
//                               //title
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 10, left: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Text(
//                                       "班组绩效",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 18, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "排名",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 16,
//                                           color: Colors.blueAccent),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               //分割线
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 5, left: 5, bottom: 10),
//                                 child: DividerLine(),
//                               ),
//
//                               Container(
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     Expanded(
//
//                                         child: new Container(
//                                           child: Padding(
//                                             padding: EdgeInsets.only(left: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   "优秀",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w500),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//
//                                                       Text("姓名"),
//
//
//                                                       Text("积分"),
//
//                                                       Text("排名"),
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//                                                       Image.asset("images/icon_no_1.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//                                                       Image.asset("images/icon_no_2.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//
//                                                       Image.asset("images/icon_no_3.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 )
//
//                                               ],
//                                             ),
//                                           ),
//                                         )),
//
//                                     ColumDividerLine(),
//
//
//                                     Expanded(
//
//                                         child: new Container(
//                                           child: Padding(
//                                             padding: EdgeInsets.only(left: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   "加油",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w500),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//
//                                                       Text("姓名"),
//
//
//                                                       Text("积分"),
//
//                                                       Text("排名"),
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//                                                       Image.asset("images/icon_no_1.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//                                                       Image.asset("images/icon_no_2.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三",style: TextStyle(fontFamily: "HanaleiFill",)),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//
//                                                       Image.asset("images/icon_no_3.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 )
//
//                                               ],
//                                             ),
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
                      ],
                    ),
                  ));
            }


          });
    }else{
      return  StreamBuilder<ApiResponse<YesterDayEntity>>(
          stream: userBloc.mMonthEntityEntity.stream,
          builder: (context, AsyncSnapshot<ApiResponse<YesterDayEntity>> response) {

            if(response.data.status==Status.LOADING){

              return new Scaffold(
                  appBar: AppBar(
                    title: Text("绩效"),
                    centerTitle: true,
                  ),
                  body: new ProgressHUD(
                    backgroundColor: Colors.black12,
                    color: Colors.white,
                    containerColor: Colors.blue,
                    borderRadius: 5.0,
                    text: 'Loading...',
                  )

              );

            }else if(response.data.status==Status.SUCCESS){

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
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(7.0))),
                              //设置圆角
                              child: Column(
                                children: <Widget>[
                                  //one
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "我的绩效",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 17, color: Colors.black),
                                        ),
                                        Text(
                                          "查看考核标准",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 16,
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                  ),

                                  //分割线
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 5, left: 5, bottom: 10),
                                    child: DividerLine(),
                                  ),
                                  new Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              _getTime(context);
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  _currentSelection == 0
                                                      ? split[0] +
                                                      "年" +
                                                      split[1] +
                                                      "月"
                                                      : monthSplit[0] + "年",
                                                  style: TextStyle(fontSize: 16),
                                                ),
                                                new Padding(
                                                  padding:
                                                  EdgeInsets.only(top: 10),
                                                  child: Text(
                                                    _currentSelection == 0
                                                        ? split[2] + "日"
                                                        : monthSplit[1] + "月",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.blueAccent),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          DUText(
                                           "累计积分",
                                              "暂无"),
                                          DUText(
                                            "累计积分排名",
                                              "暂无")
                                        ],
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 10, bottom: 10),
                                        child: Text("我的上级:暂无"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        //班组绩效
                        new Padding(
                          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Container(
                            child: Card(
                              elevation: 3,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(7.0))),
                              child: Column(
                                children: <Widget>[
                                  //title
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "班组绩效",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 18, color: Colors.black),
                                        ),
                                        Text(
                                          "排名",
                                          style: TextStyle(fontFamily: "Roboto",
                                              fontSize: 16,
                                              color: Colors.blueAccent),
                                        )
                                      ],
                                    ),
                                  ),
                                  //分割线
                                  new Padding(
                                    padding: EdgeInsets.only(
                                        top: 5, right: 5, left: 5, bottom: 10),
                                    child: DividerLine(),
                                  ),

                                  Container(
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(

                                            child: new Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "优秀",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[

                                                          Text("姓名"),


                                                          Text("积分"),

                                                          Text("排名"),

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),

                                                          Image.asset("images/icon_no_1.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),

                                                          Image.asset("images/icon_no_2.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),


                                                          Image.asset("images/icon_no_3.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            )),

                                        ColumDividerLine(),


                                        Expanded(

                                            child: new Container(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      "加油",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[

                                                          Text("姓名"),


                                                          Text("积分"),

                                                          Text("排名"),

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
                                                          Image.asset("images/icon_no_1.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三"),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
                                                          Image.asset("images/icon_no_2.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Text("张三",style: TextStyle(fontFamily: "HanaleiFill",)),
                                                          Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),


                                                          Image.asset("images/icon_no_3.png",height: 25,width: 25,)

                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));

            }else{
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
//                     new Padding(
//                       padding: EdgeInsets.only(top: 10, left: 5, right: 5),
//                       child: Container(
//                         width: double.maxFinite,
//                         child: Card(
//                           elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(7.0))),
//                           //设置圆角
//                           child: Column(
//                             children: <Widget>[
//                               //one
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 10, left: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Text(
//                                       "我的绩效",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 17, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "查看考核标准",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 16,
//                                           color: Colors.blueAccent),
//                                     )
//                                   ],
//                                 ),
//                               ),
//
//                               //分割线
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 5, left: 5, bottom: 10),
//                                 child: DividerLine(),
//                               ),
//                               new Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                     children: <Widget>[
//                                       GestureDetector(
//                                         onTap: () {
//                                           _getTime(context);
//                                         },
//                                         child: Column(
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Text(
//                                               _currentSelection == 0
//                                                   ? split[0] +
//                                                   "年" +
//                                                   split[1] +
//                                                   "月"
//                                                   : monthSplit[0] + "年",
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                             new Padding(
//                                               padding:
//                                               EdgeInsets.only(top: 10),
//                                               child: Text(
//                                                 _currentSelection == 0
//                                                     ? split[2] + "日"
//                                                     : monthSplit[1] + "月",
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                     FontWeight.w600,
//                                                     color: Colors.blueAccent),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       DUText(
//                                           _currentSelection == 0
//                                               ? "我的积分"
//                                               : "累计积分",
//                                           "暂无"),
//                                       DUText(
//                                           _currentSelection == 0
//                                               ? "我的排名"
//                                               : "累计积分排名",
//                                           "暂无")
//                                     ],
//                                   ),
//                                   new Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 10, left: 10, bottom: 10),
//                                     child: Text("我的上级:暂无"),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     //班组绩效
//                     new Padding(
//                       padding: EdgeInsets.only(top: 5, left: 5, right: 5),
//                       child: Container(
//                         child: Card(
//                           elevation: 3,
//                           shape: const RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(7.0))),
//                           child: Column(
//                             children: <Widget>[
//                               //title
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 10, left: 10),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     Text(
//                                       "班组绩效",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 18, color: Colors.black),
//                                     ),
//                                     Text(
//                                       "排名",
//                                       style: TextStyle(fontFamily: "Roboto",
//                                           fontSize: 16,
//                                           color: Colors.blueAccent),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               //分割线
//                               new Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 5, right: 5, left: 5, bottom: 10),
//                                 child: DividerLine(),
//                               ),
//
//                               Container(
//                                 child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     Expanded(
//
//                                         child: new Container(
//                                           child: Padding(
//                                             padding: EdgeInsets.only(left: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   "优秀",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w500),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//
//                                                       Text("姓名"),
//
//
//                                                       Text("积分"),
//
//                                                       Text("排名"),
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//                                                       Image.asset("images/icon_no_1.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//                                                       Image.asset("images/icon_no_2.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//
//                                                       Image.asset("images/icon_no_3.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 )
//
//                                               ],
//                                             ),
//                                           ),
//                                         )),
//
//                                     ColumDividerLine(),
//
//
//                                     Expanded(
//
//                                         child: new Container(
//                                           child: Padding(
//                                             padding: EdgeInsets.only(left: 10),
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   "加油",
//                                                   style: TextStyle(
//                                                       color: Colors.black,
//                                                       fontSize: 15,
//                                                       fontWeight: FontWeight.w500),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//
//                                                       Text("姓名"),
//
//
//                                                       Text("积分"),
//
//                                                       Text("排名"),
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//                                                       Image.asset("images/icon_no_1.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三"),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//                                                       Image.asset("images/icon_no_2.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: 10,top: 10,right: 10),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Text("张三",style: TextStyle(fontFamily: "HanaleiFill",)),
//                                                       Text("10",style: TextStyle(fontSize: 17,color: Colors.blueAccent,fontWeight: FontWeight.w600),),
//
//
//                                                       Image.asset("images/icon_no_3.png",height: 25,width: 25,)
//
//                                                     ],
//                                                   ),
//                                                 )
//
//                                               ],
//                                             ),
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
                      ],
                    ),
                  ));
            }


          });
    }



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userBloc.disposeLoginSubject();
    userBloc.disposeMonthDataSubject();
    userBloc.disposeYesterDayDataSubject();
  }

  //获取时间选择器,并且刷新数据
  _getTime(BuildContext context) {
    _currentSelection == 0
        ? DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2000, 3),
            maxTime: DateTime(2039, 6),
            onChanged: (date) {}, onConfirm: (date) {
            setState(() {
              String formatDate =
                  DateUtil.formatDate(date, format: "yyyy-MM-dd");
              YesTerDayPostBean  bean =YesTerDayPostBean(TenantId:Api.TenantId ,AppCode:"EMS",ApiCode:"GetUserInfoOfDay" ,ShiftDate:formatDate ,TeamId:teamId ,UserCode:Api.UserCode );
              userBloc.getYesterDayData(bean);
              split = formatDate.split("-");
            });
          }, currentTime: DateTime.now(), locale: LocaleType.zh)
        : DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2000, 3),
            maxTime: DateTime(2039, 6),
            onChanged: (date) {}, onConfirm: (date) {
            setState(() {
              String formatDate =
                  DateUtil.formatDate(date, format: "yyyy-MM-dd");
              monthSplit = formatDate.split("-");
              MonthDataPostBean  monthDataPostBean =new  MonthDataPostBean(UserCode:Api.UserCode ,TeamId: teamId,ShiftDate:monthSplit[0]+"-"+monthSplit[1]+"-"+"01" ,ApiCode:"GetUserInfoOfMonth" ,AppCode:"EMS" ,TenantId:Api.TenantId );
              userBloc.getMonthData(monthDataPostBean);
            });
          }, currentTime: DateTime.now(), locale: LocaleType.zh);
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        new Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            data,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}






