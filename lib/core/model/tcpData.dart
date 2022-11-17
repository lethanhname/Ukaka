class TCPData {
  String ip;
  int port;

  TCPData(this.ip, this.port);

  factory TCPData.fromJson(dynamic json) {
    return TCPData(json['ip'] as String, json['port'] as int);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['port'] = port;
    return data;
  }
}