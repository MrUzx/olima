class Category {
  final int id;
  final String nomi;
  final int bolinadi;
  final int status;

  Category({
    required this.id,
    required this.nomi,
    required this.bolinadi,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      nomi: json['nomi'],
      bolinadi: json['bolinadi'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nomi': nomi,
      'bolinadi': bolinadi,
      'status': status,
    };
  }
}

class ApiResponse {
  final bool success;
  final List<Category> data;

  ApiResponse({
    required this.success,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      data: (json['data'] as List)
          .map((item) => Category.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((category) => category.toJson()).toList(),
    };
  }
}
