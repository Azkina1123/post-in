part of "models.dart";

class Following {
  int id;
  int userId2;  // diikuti
  int userId;   // yang mengikuti

  Following({
    required this.id,
    required this.userId2,
    required this.userId,
  });
}
