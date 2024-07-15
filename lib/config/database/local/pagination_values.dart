class PaginationValues {
  static Map<String, dynamic> getOptions({int page = 1, int pageSize = 60000}) =>
      {'page': page, 'pageSize': pageSize};
}
