part of "models.dart";

class Following {
  int id;
  String? docId;
  int userId2; // diikuti
  int userId; // yang mengikuti

  Following({
    required this.id,
    this.docId,
    required this.userId2,
    required this.userId,
  });
}
