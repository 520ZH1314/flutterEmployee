class YesterDayEntity {
	String status;
	String message;
	String total;
	String page;
	String records;
	List<YesterDayRow> rows;

	YesterDayEntity({this.status, this.message, this.total, this.page, this.records, this.rows});

	YesterDayEntity.fromJson(Map<String, dynamic> json) {
		status = json['Status'];
		message = json['Message'];
		total = json['Total'];
		page = json['Page'];
		records = json['Records'];
		if (json['Rows'] != null) {
			rows = new List<YesterDayRow>();(json['Rows'] as List).forEach((v) { rows.add(new YesterDayRow.fromJson(v)); });
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

class YesterDayRow {
	YesterDayRowsReturndayinfo returndayInfo;

	YesterDayRow({this.returndayInfo});

	YesterDayRow.fromJson(Map<String, dynamic> json) {
		returndayInfo = json['returndayInfo'] != null ? new YesterDayRowsReturndayinfo.fromJson(json['returndayInfo']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.returndayInfo != null) {
      data['returndayInfo'] = this.returndayInfo.toJson();
    }
		return data;
	}
}

class YesterDayRowsReturndayinfo {
	List<YesterDayRowsReturndayinfoUserinfo> userInfo;
	List<YesterDayRowsReturndayinfoUnderteaminfo> underTeamInfo;
	List<YesterDayRowsReturndayinfoTopteaminfo> topTeamInfo;

	YesterDayRowsReturndayinfo({this.userInfo, this.underTeamInfo, this.topTeamInfo});

	YesterDayRowsReturndayinfo.fromJson(Map<String, dynamic> json) {
		if (json['userInfo'] != null) {
			userInfo = new List<YesterDayRowsReturndayinfoUserinfo>();(json['userInfo'] as List).forEach((v) { userInfo.add(new YesterDayRowsReturndayinfoUserinfo.fromJson(v)); });
		}
		if (json['underTeamInfo'] != null) {
			underTeamInfo = new List<YesterDayRowsReturndayinfoUnderteaminfo>();(json['underTeamInfo'] as List).forEach((v) { underTeamInfo.add(new YesterDayRowsReturndayinfoUnderteaminfo.fromJson(v)); });
		}
		if (json['topTeamInfo'] != null) {
			topTeamInfo = new List<YesterDayRowsReturndayinfoTopteaminfo>();(json['topTeamInfo'] as List).forEach((v) { topTeamInfo.add(new YesterDayRowsReturndayinfoTopteaminfo.fromJson(v)); });
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

class YesterDayRowsReturndayinfoUserinfo {
	double score;
	String userName;
	String userCode;
	String teamLeaderName;
	int seq;

	YesterDayRowsReturndayinfoUserinfo({this.score, this.userName, this.userCode, this.teamLeaderName, this.seq});

	YesterDayRowsReturndayinfoUserinfo.fromJson(Map<String, dynamic> json) {
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

class YesterDayRowsReturndayinfoUnderteaminfo {
	double score;
	String userName;
	String userCode;

	YesterDayRowsReturndayinfoUnderteaminfo({this.score, this.userName, this.userCode});

	YesterDayRowsReturndayinfoUnderteaminfo.fromJson(Map<String, dynamic> json) {
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

class YesterDayRowsReturndayinfoTopteaminfo {
	double score;
	String userName;
	String userCode;

	YesterDayRowsReturndayinfoTopteaminfo({this.score, this.userName, this.userCode});

	YesterDayRowsReturndayinfoTopteaminfo.fromJson(Map<String, dynamic> json) {
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
