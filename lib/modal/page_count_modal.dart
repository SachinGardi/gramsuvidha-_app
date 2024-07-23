import 'dart:convert';

PageCountModal pageCountModalFromJson(String str) =>
    PageCountModal.fromJson(json.decode(str));

String pageCountModalToJson(PageCountModal data) => json.encode(data.toJson());

class PageCountModal {
  int? pageNo;
  int? totalPages;
  int? pageCount;
  int? totalCount;

  PageCountModal({
    this.pageNo,
    this.totalPages,
    this.pageCount,
    this.totalCount,
  });

  factory PageCountModal.fromJson(Map<String, dynamic> json) => PageCountModal(
        pageNo: json["pageNo"],
        totalPages: json["totalPages"],
        pageCount: json["pageCount"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "pageNo": pageNo,
        "totalPages": totalPages,
        "pageCount": pageCount,
        "totalCount": totalCount,
      };
}
