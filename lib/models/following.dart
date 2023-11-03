part of "models.dart";

class Following {
  int id;
  int userId1;  // diikuti
  int userId2;  // yang mengikuti

  Following({
    required this.id,
    required this.userId1,
    required this.userId2,
  });
}
