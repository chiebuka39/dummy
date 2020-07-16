class Result<T>{
  T data;
  bool error;
  String errorMessage;

  Result({this.data, this.error, this.errorMessage});
}