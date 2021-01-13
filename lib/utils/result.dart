class Result<T>{
  T data;
  bool error;
  bool networkAvailable;
  String errorMessage;

  Result({this.data, this.error, this.errorMessage, this.networkAvailable});
}