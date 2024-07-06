class AboutPageRes {
  bool status;
  List<AboutDataModel> data;
  String message;

  AboutPageRes({
    this.status = false,
    this.data = const <AboutDataModel>[],
    this.message = "",
  });

  factory AboutPageRes.fromJson(Map<String, dynamic> json) {
    return AboutPageRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List
          ? List<AboutDataModel>.from(json['data'].map((x) => AboutDataModel.fromJson(x)))
          : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class AboutDataModel {
  int id;
  String slug;
  String name;
  String url;

  AboutDataModel({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.url = "",
  });

  factory AboutDataModel.fromJson(Map<String, dynamic> json) {
    return AboutDataModel(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      url: json['url'] is String ? json['url'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'url': url,
    };
  }
}
