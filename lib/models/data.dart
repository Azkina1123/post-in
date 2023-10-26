part of "models.dart";

Map<String, Color> colors = {
  "dark-jungle-green": Color.fromARGB(255, 33, 31, 33),
  "milk-white": Color.fromARGB(255, 251, 251, 255),
  "smoky-topaz": Color.fromARGB(255, 156, 51, 78),
  "soft-pink": Color.fromARGB(255, 255, 176, 197),
  "sand": Color.fromARGB(255, 244, 195, 135),
  "languid-lavender": Color.fromARGB(255, 215, 199, 217)
};

// data dummy
List<Post> posts = [

  Post(id: 1, createdAt: DateTime.utc(2023, 02, 22, 17, 12), content: "Selamat ulang tahun yang ke-25, [nama teman]! Semoga hari ini penuh kebahagiaan dan keberuntungan. Semoga semua impianmu terwujud. 🎂🎉, #UlangTahun #TemanTerbaik", userId: 1),
  Post(id: 1, createdAt: DateTime.utc(2023, 02, 22, 17, 12), content: "Hari pertama liburan di [nama destinasi]! Pemandangan luar biasa dan cuaca cerah. Bersama [nama teman/keluarga] siap menjelajahi petualangan ini. 🏝️☀️ #LiburanSeru #Petualangan", userId: 1, img: NetworkImage("https://picsum.photos/800/500")),
  Post(id: 1, createdAt: DateTime.utc(2023, 02, 22, 17, 12), content: "Cuaca cerah hari ini, matahari bersinar terang! Semoga hari ini penuh semangat. ☀️ #CuacaBagus #Semangat", userId: 1),
  Post(id: 1, createdAt: DateTime.utc(2023, 02, 22, 17, 12), content: "Senang mengumumkan bahwa saya berhasil menyelesaikan proyek [nama proyek] hari ini! Terima kasih kepada semua yang telah mendukung saya. 💪🎉 #Pencapaian #ProyekSelesai", userId: 1, img: NetworkImage("https://picsum.photos/800/400")),
  Post(id: 1, createdAt: DateTime.utc(2023, 02, 22, 17, 12), content: "Keindahan alam yang menenangkan. Saya merasa beruntung bisa melihat pemandangan seperti ini. 🏞️❤️ #PemandanganAlam #Kedamaian", userId: 1),
];
