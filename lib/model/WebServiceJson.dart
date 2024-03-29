class WebServiceJson {
  String timestamp;
  int status;
  String error;
  String message;
  String path;

  WebServiceJson(
      {this.timestamp, this.status, this.error, this.message, this.path});

  WebServiceJson.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    status = json['status'];
    error = json['error'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}
