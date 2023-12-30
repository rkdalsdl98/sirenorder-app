class SuccessResponse<T> {
  T data;
  dynamic metadata;
  final int status;

  SuccessResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        metadata = json['metadata'],
        status = json['status'];
}

class FailedResponse {
  final String message;
  final int status;
  String? substatus;

  FailedResponse.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        status = json['status'],
        substatus = json['substatus'];
}
