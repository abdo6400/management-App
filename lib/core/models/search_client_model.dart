import '../entities/search_client.dart';

class SearchClientModel extends SearchClient {
  SearchClientModel(
      {required super.id, required super.name, required super.phoneNumber});

  factory SearchClientModel.fromJson(Map<String, dynamic> json) =>
      SearchClientModel(
        id: json["id"],
        name: json["name"],
        phoneNumber: json["phone"],
      );
}
