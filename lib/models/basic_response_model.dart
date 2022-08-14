class BasicResponse {
  int? statusCode;
  String? messages;
  Map<dynamic, dynamic>? data;

  BasicResponse({
    this.statusCode,
    this.messages,
    this.data,
  });
}
