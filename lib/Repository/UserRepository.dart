/* Created by Sahil Bharti on 13/4/19.
 *
*/


import 'package:employee/bean/performance/PostIsLeaderBean.dart';
import 'package:employee/bean/performance/data_entity.dart';
import 'package:employee/http/utils/ApiResponse.dart';
import 'package:employee/http/call/LoginCall.dart';

import 'package:rxdart/rxdart.dart';



class UserRepository {

  /// create new Call  for getData  and execute the call and post it on given BehaviorSubject.
  /// params 1. request -> request data for api
  /// params 2. BehaviourSubject -> in which data is sinc/post
  executeLogin(PostIsLeaderBean request, BehaviorSubject<ApiResponse<DataEntity>> responseSubject) {
    new LoginCall(request, responseSubject).execute();
  }

}




