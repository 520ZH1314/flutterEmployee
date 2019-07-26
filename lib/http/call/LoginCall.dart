/* Created by Sahil Bharti on 17/4/19.
 *
*/

import 'package:dio/dio.dart';
import 'package:employee/bean/performance/PostIsLeaderBean.dart';
import 'package:employee/bean/performance/data_entity.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/http/utils/DataFetchCall.dart';

import 'package:rxdart/rxdart.dart';


import 'package:employee/http/service/ApiService.dart';
class LoginCall extends DataFetchCall<DataEntity> {
  PostIsLeaderBean _request;
  LoginCall(PostIsLeaderBean request, BehaviorSubject<ApiResponse<DataEntity>> responseSubject) : super(responseSubject) {this._request = request;}

  /// if return false then createApiAsyc is called
  /// if return true then loadFromDB Function  is called
  @override
  bool shouldFetchFromDB() {
    return false;
  }

  /// called when shouldFetchfromDB() is returning true
  @override
  void loadFromDB() {

    ///  get data from DB todo post/sinc on behaviourSubject after
  }
  /// called when shouldFetchfromDB() is returning false

  @override
  Future<Response> createApiAsync() {
    /// need to return APIService async task for API request
    return apiServiceInstance.login(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(DataEntity response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  DataEntity parseJson(Response response) {
    return DataEntity.fromJson(response.data);
  }
}