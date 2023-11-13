part of "models.dart";

class Following {
  int id;
  String? idDoc;
  int userId2; // diikuti
  int userId; // yang mengikuti

  Following({
    required this.id,
    this.idDoc,
    required this.userId2,
    required this.userId,
  });
}
