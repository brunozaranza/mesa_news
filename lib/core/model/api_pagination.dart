class ApiPagination {
  int currentPage;
  int perPage;
  int totalPages;
  int totalItems;

  ApiPagination.fromJson(Map<String, dynamic> map) {
    this.currentPage = map["current_page"];
    this.perPage = map["per_page"];
    this.totalPages = map["total_pages"];
    this.totalItems = map["total_items"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total_pages'] = this.totalPages;
    data['total_items'] = this.totalItems;

    return data;
  }
}