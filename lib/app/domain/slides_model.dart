class SlidesModel {
  List<Slide>? slides;

  // SlidesModel({this.slides});

  SlidesModel.fromJson(Map<String, dynamic> json) {
    if (json['slides'] != null) {
      slides = <Slide>[];
      json['slides'].forEach((v) {
        slides!.add(Slide.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (slides != null) {
  //     data['slides'] = slides!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Slide {
  String? type;
  String? title;
  String? mediaUrl;

  Slide({this.type, this.title, this.mediaUrl});

  Slide.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    mediaUrl = json['mediaUrl'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['type'] = type;
  //   data['title'] = title;
  //   data['mediaUrl'] = mediaUrl;
  //   return data;
  // }
}
