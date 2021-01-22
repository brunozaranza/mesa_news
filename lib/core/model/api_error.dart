class ApiError {
  List<ApiErrorItem> errors;

  ApiError({this.errors});

  ApiError.fromJson(Map<String, dynamic> map) {
    var e = map['errors'] as List;

    this.errors = e.map((i) => ApiErrorItem.fromJson(i)).cast<ApiErrorItem>().toList();
  }
}

class ApiErrorItem {

  String code;
  String field;
  String message;

  ApiErrorItem({this.code, this.field, this.message});

  ApiErrorItem.fromJson(Map<String, dynamic> map) {
    this.code = map["code"];
    this.field = map["field"];
    this.message = map["message"];
  }
}