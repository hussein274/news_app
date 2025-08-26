import 'sources_dm.dart';

class SourceResponse {
  SourceResponse({
      this.status, 
      this.sources,});

  SourceResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['sources'] != null) {
      sources = [];
      json['sources'].forEach((v) {
        sources?.add(SourceDm.fromJson(v));
      });
    }
  }
  String? status;
  List<SourceDm>? sources;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (sources != null) {
      map['sources'] = sources?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}