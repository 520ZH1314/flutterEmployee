
//是否是领导
class DataEntity {
	String status;
	String message;
	String total;
	String page;
	String records;
	List<DataRow> rows;

	DataEntity({this.status, this.message, this.total, this.page, this.records, this.rows});

	DataEntity.fromJson(Map<String, dynamic> json) {
		status = json['Status'];
		message = json['Message'];
		total = json['Total'];
		page = json['Page'];
		records = json['Records'];
		if (json['Rows'] != null) {
			rows = new List<DataRow>();(json['Rows'] as List).forEach((v) { rows.add(new DataRow.fromJson(v)); });
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

class DataRow {
	bool isTeamLeader;
	String teamLeaderUserName;
	String teamLeaderUserId;
	String teamName;
	String teamId;

	DataRow({this.isTeamLeader, this.teamLeaderUserName, this.teamLeaderUserId, this.teamName, this.teamId});

	DataRow.fromJson(Map<String, dynamic> json) {
		isTeamLeader = json['IsTeamLeader'];
		teamLeaderUserName = json['TeamLeaderUserName'];
		teamLeaderUserId = json['TeamLeaderUserId'];
		teamName = json['TeamName'];
		teamId = json['TeamId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['IsTeamLeader'] = this.isTeamLeader;
		data['TeamLeaderUserName'] = this.teamLeaderUserName;
		data['TeamLeaderUserId'] = this.teamLeaderUserId;
		data['TeamName'] = this.teamName;
		data['TeamId'] = this.teamId;

		return data;
	}
}
