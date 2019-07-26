import 'package:dio/dio.dart';
import 'package:employee/bean/performance/month_data_post_bean.dart';
import 'package:employee/bean/performance/yester_day_entity.dart';
import 'package:employee/http/service/ApiService.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/http/utils/DataFetchCall.dart';
import 'package:rxdart/rxdart.dart';

class  MonthPerformanceCall extends DataFetchCall<YesterDayEntity>{
  MonthDataPostBean entity;
  MonthPerformanceCall(MonthDataPostBean bean,BehaviorSubject<ApiResponse<YesterDayEntity>> observable) : super(observable){
    this.entity=bean;
  }

  @override
  Future<Response> createApiAsync() {
    // TODO: implement createApiAsync
    return  apiServiceInstance.getMonthPerformanceData(entity);
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