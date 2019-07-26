//昨日绩效

import 'package:dio/src/response.dart';
import 'package:employee/bean/performance/YesTerDayPostBean.dart';
import 'package:employee/bean/performance/yester_day_entity.dart';
import 'package:employee/http/service/ApiService.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/http/utils/DataFetchCall.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';

class  YesterdayPerformanceCall extends DataFetchCall<YesterDayEntity>{
  YesTerDayPostBean entity;
  YesterdayPerformanceCall(YesTerDayPostBean bean,BehaviorSubject<ApiResponse<YesterDayEntity>> observable) : super(observable){
     this.entity=bean;
  }

  @override
  Future<Response> createApiAsync() {
    // TODO: implement createApiAsync
    return  apiServiceInstance.getYesterdayperFormanceData(entity);
  }

  @override
  void loadFromDB() {
    // TODO: implement loadFromDB
  }

  @override
  void onSuccess(YesterDayEntity response) {
    // TODO: implement onSuccess
  }

  @override
  YesterDayEntity parseJson(Response response) {
    // TODO: implement parseJson
    return YesterDayEntity.fromJson(response.data);
  }

  @override
  bool shouldFetchFromDB() {
    // TODO: implement shouldFetchFromDB
    return false;
  }

}