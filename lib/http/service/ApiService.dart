/* Created by Sahil Bharti on 13/4/19.
 *
*/

import 'package:dio/dio.dart';
import 'package:employee/bean/performance/PostIsLeaderBean.dart';
import 'package:employee/bean/performance/YesTerDayPostBean.dart';
import 'package:employee/bean/performance/month_data_post_bean.dart';
import 'package:employee/http/utils/DNetworkUtil.dart';

import '../Api.dart';



/// write your all API Async requests here
class ApiService {
  NetworkUtil networkUtil = NetworkUtil();

  Future<Response> login(PostIsLeaderBean loginRequest) {
    return networkUtil.post(Api.ISTEAMLEADER, loginRequest.toJson());
  }



  //获取昨日绩效
  Future<Response> getYesterdayperFormanceData(YesTerDayPostBean loginRequest) {
    return networkUtil.post(Api.ISTEAMLEADER, loginRequest.toJson());
  }


  //获取月度绩效
  Future<Response> getMonthPerformanceData( MonthDataPostBean loginRequest) {
    return networkUtil.post(Api.ISTEAMLEADER, loginRequest.toJson());
  }



}

///Single final Object of API Service
final apiServiceInstance = ApiService();
