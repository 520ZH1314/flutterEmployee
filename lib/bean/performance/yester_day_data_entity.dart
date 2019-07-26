class YesterDayDataEntity {
	String status;
	String message;
	String total;
	String page;
	String records;
	List<YesterDayDataRow> rows;

	YesterDayDataEntity({this.status, this.message, this.total, this.page, this.records, this.rows});

	YesterDayDataEntity.fromJson(Map<String, dynamic> json) {
		status = json['Status'];
		message = json['Message'];
		total = json['Total'];
		page = json['Page'];
		records = json['Records'];
		if (json['Rows'] != null) {
			rows = new List<YesterDayDataRow>();(json['Rows'] as List).forEach((v) { rows.add(new YesterDayDataRow.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Status'] = this.status;
		data['Message'] = this.message;
		data['Total'] = this.total;
		data['Page'] = this.page;
		data['Records'] = this.records;
		if (this.rows != null) {
      data['Rows'] =  this.rows.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class YesterDayDataRow {
	YesterDayDataRowsReturndayinfo returndayInfo;

	YesterDayDataRow({this.returndayInfo});

	YesterDayDataRow.fromJson(Map<String, dynamic> json) {
		returndayInfo = json['returndayInfo'] != null ? new YesterDayDataRowsReturndayinfo.fromJson(json['returndayInfo']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.returndayInfo != null) {
      data['returndayInfo'] = this.returndayInfo.toJson();
    }
		return data;
	}
}

class YesterDayDataRowsReturndayinfo {
	List<YesterDayDataRowsReturndayinfoUserinfo> userInfo;
	List<YesterDayDataRowsReturndayinfoUnderteaminfo> underTeamInfo;
	List<YesterDayDataRowsReturndayinfoTopteaminfo> topTeamInfo;

	YesterDayDataRowsReturndayinfo({this.userInfo, this.underTeamInfo, this.topTeamInfo});

	YesterDayDataRowsReturndayinfo.fromJson(Map<String, dynamic> json) {
		if (json['userInfo'] != null) {
			userInfo = new List<YesterDayDataRowsReturndayinfoUserinfo>();(json['userInfo'] as List).forEach((v) { userInfo.add(new YesterDayDataRowsReturndayinfoUserinfo.fromJson(v)); });
		}
		if (json['underTeamInfo'] != null) {
			underTeamInfo = new List<YesterDayDataRowsReturndayinfoUnderteaminfo>();(json['underTeamInfo'] as List).forEach((v) { underTeamInfo.add(new YesterDayDataRowsReturndayinfoUnderteaminfo.fromJson(v)); });
		}
		if (json['topTeamInfo'] != null) {
			topTeamInfo = new List<YesterDayDataRowsReturndayinfoTopteaminfo>();(json['topTeamInfo'] as List).forEach((v) { topTeamInfo.add(new YesterDayDataRowsReturndayinfoTopteaminfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.userInfo != null) {
      data['userInfo'] =  this.userInfo.map((v) => v.toJson()).toList();
    }
		if (this.underTeamInfo != null) {
      data['underTeamInfo'] =  this.underTeamInfo.map((v) => v.toJson()).toList();
    }
		if (this.topTeamInfo != null) {
      data['topTeamInfo'] =  this.topTeamInfo.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class YesterDayDataRowsReturndayinfoUserinfo {
	int score;
	String userName;
	String userCode;
	String teamLeaderName;
	int seq;

	YesterDayDataRowsReturndayinfoUserinfo({this.score, this.userName, this.userCode, this.teamLeaderName, this.seq});

	YesterDayDataRowsReturndayinfoUserinfo.fromJson(Map<String, dynamic> json) {
		score = json['Score'];
		userName = json['UserName'];
		userCode = json['UserCode'];
		teamLeaderName = json['TeamLeaderName'];
		seq = json['Seq'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Score'] = this.score;
		data['UserName'] = this.userName;
		data['UserCode'] = this.userCode;
		data['TeamLeaderName'] = this.teamLeaderName;
		data['Seq'] = this.seq;
		return data;
	}
}

class YesterDayDataRowsReturndayinfoUnderteaminfo {
	int score;
	String userName;
	String userCode;

	YesterDayDataRowsReturndayinfoUnderteaminfo({this.score, this.userName, this.userCode});

	YesterDayDataRowsReturndayinfoUnderteaminfo.fromJson(Map<String, dynamic> json) {
		score = json['Score'];
		userName = json['UserName'];
		userCode = json['UserCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Score'] = this.score;
		data['UserName'] = this.userName;
		data['UserCode'] = this.userCode;
		return data;
	}
}

class YesterDayDataRowsReturndayinfoTopteaminfo {
	int score;
	String userName;
	String userCode;

	YesterDayDataRowsReturndayinfoTopteaminfo({this.score, this.userName, this.userCode});

	YesterDayDataRowsReturndayinfoTopteaminfo.fromJson(Map<String, dynamic> json) {
		score = json['Score'];
		userName = json['UserName'];
		userCode = json['UserCode'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Score'] = this.score;
		data['UserName'] = this.userName;
		data['UserCode'] = this.userCode;
		return data;
	}
}
