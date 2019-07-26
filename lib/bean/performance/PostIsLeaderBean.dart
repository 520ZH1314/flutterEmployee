class PostIsLeaderBean {
  String AppCode;
  String ApiCode;
  String TenantId;
  String UserId;

  PostIsLeaderBean({this.AppCode, this.ApiCode, this.TenantId, this.UserId});

  PostIsLeaderBean.fromJson(Map<String, dynamic> json) {    
    this.AppCode = json['AppCode'];
    this.ApiCode = json['ApiCode'];
    this.TenantId = json['TenantId'];
    this.UserId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppCode'] = this.AppCode;
    data['ApiCode'] = this.ApiCode;
    data['TenantId'] = this.TenantId;
    data['UserId'] = this.UserId;
    return data;
  }



  @override
  String toString() {
    return 'PostIsLeaderBean{AppCode: $AppCode, ApiCode: $ApiCode, TenantId: $TenantId, UserId: $UserId}';
  }

}
