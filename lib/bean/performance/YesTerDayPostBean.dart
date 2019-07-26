class YesTerDayPostBean {
  String AppCode;
  String ApiCode;
  String UserCode;
  String ShiftDate;
  String TenantId;
  String TeamId;

  YesTerDayPostBean({this.AppCode, this.ApiCode, this.UserCode, this.ShiftDate, this.TenantId, this.TeamId});

  YesTerDayPostBean.fromJson(Map<String, dynamic> json) {    
    this.AppCode = json['AppCode'];
    this.ApiCode = json['ApiCode'];
    this.UserCode = json['UserCode'];
    this.ShiftDate = json['ShiftDate'];
    this.TenantId = json['TenantId'];
    this.TeamId = json['TeamId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppCode'] = this.AppCode;
    data['ApiCode'] = this.ApiCode;
    data['UserCode'] = this.UserCode;
    data['ShiftDate'] = this.ShiftDate;
    data['TenantId'] = this.TenantId;
    data['TeamId'] = this.TeamId;
    return data;
  }

}
