class DeleteResponse {
  final int registrosAfectados;

  DeleteResponse({required this.registrosAfectados});

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(
      registrosAfectados: json['registrosAfectados'],
    );
  }
}
