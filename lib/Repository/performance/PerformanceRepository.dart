
//绩效数据仓库
import 'package:employee/bean/performance/YesTerDayPostBean.dart';
import 'package:employee/bean/performance/month_data_post_bean.dart';
import 'package:employee/http/call/performance/month_data_call.dart';
import 'package:employee/http/call/performance/yesterday_per_call.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/bean/performance/yester_day_entity.dart';

import 'package:rxdart/subjects.dart';

class  PerformanceRepository{

  //获取昨日绩效
  getYesterdayData(YesTerDayPostBean bean,BehaviorSubject<ApiResponse<YesterDayEntity>> responseSubject){
    new YesterdayPerformanceCall(bean,responseSubject).execute();
  }


  //获取月度绩效
  getMonthdayData(MonthDataPostBean bean,BehaviorSubject<ApiResponse<YesterDayEntity>> responseSubject){
    new MonthPerformanceCall(bean,responseSubject).execute();
  }
}