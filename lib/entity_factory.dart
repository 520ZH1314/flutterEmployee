import 'package:employee/bean/performance/yester_day_data_entity.dart';
import 'package:employee/bean/performance/data_entity.dart';
import 'package:employee/bean/performance/yester_day_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "YesterDayDataEntity") {
      return YesterDayDataEntity.fromJson(json) as T;
    } else if (T.toString() == "DataEntity") {
      return DataEntity.fromJson(json) as T;
    } else if (T.toString() == "YesterDayEntity") {
      return YesterDayEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}