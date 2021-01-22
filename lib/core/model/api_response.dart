class ApiResponse<T> {
  bool success;
  T result;
  String msg;

  ApiResponse.success(this.result, {this.msg}){
    this.success = true;
  }

  ApiResponse.error(this.msg){
    this.success = false;
  }
}