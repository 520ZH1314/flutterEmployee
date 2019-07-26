/* Created by Sahil Bharti on 13/4/19.
 *
*/

import 'package:employee/Repository/performance/PerformanceRepository.dart';
import 'package:employee/bean/performance/PostIsLeaderBean.dart';
import 'package:employee/bean/performance/YesTerDayPostBean.dart';
import 'package:employee/bean/performance/data_entity.dart';
import 'package:employee/bean/performance/month_data_post_bean.dart';
import 'package:employee/bean/performance/yester_day_entity.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'package:employee/Repository/UserRepository.dart';


//绩效Bloc
class UserBloc {
  final UserRepository _repository = UserRepository();
  final PerformanceRepository performanceRepository= PerformanceRepository();
  final BehaviorSubject<ApiResponse<DataEntity>> _subjectLogin =
  BehaviorSubject<ApiResponse<DataEntity>>();

  //昨日绩效
  final BehaviorSubject<ApiResponse<YesterDayEntity>> _mYesterDayEntityEntity = BehaviorSubject<ApiResponse<YesterDayEntity>>();

  //月度绩效
  final BehaviorSubject<ApiResponse<YesterDayEntity>> _mMonthEntityEntity = BehaviorSubject<ApiResponse<YesterDayEntity>>();


  /// Functions/Methods of get Data from Repository either from db/network
  executeLogin(PostIsLeaderBean request) {
    _repository.executeLogin(request, _subjectLogin);
  }
  // 获取昨日绩效
  getYesterDayData(YesTerDayPostBean bean){
    performanceRepository.getYesterdayData(bean, _mYesterDayEntityEntity);
  }
  // 获取月度绩效
  getMonthData(MonthDataPostBean bean){
    performanceRepository.getMonthdayData(bean, _mMonthEntityEntity);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<ApiResponse<DataEntity>> get subject => _subjectLogin;
  BehaviorSubject<ApiResponse<YesterDayEntity>> get mYesterDayEntityEntity => _mYesterDayEntityEntity;
  BehaviorSubject<ApiResponse<YesterDayEntity>> get mMonthEntityEntity => _mMonthEntityEntity;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectLogin.close();
  }

  disposeYesterDayDataSubject() {
    _mYesterDayEntityEntity.close();
  }
  disposeMonthDataSubject() {
    _mMonthEntityEntity.close();
  }

}






///final Object of User Bloc
final userBloc = UserBloc();
