part of "pages.dart";

class Introduction_Page extends StatelessWidget {
  const Introduction_Page({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      next: Text("Selanjutnya"),
      done: Text("Lanjut"),
      onDone: () {
        Navigator.of(context).pop();
        Navigator.popAndPushNamed(context, "/landing");
      },
      pages: [
        PageViewModel(
          title: " HALO !",
          body:
              "Selamat datang di aplikasi kami. Temukan pengalaman baru yang menarik!",
          image: Image.asset(
            'assets/intro1.png',
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Temukan Teman baru kalian disini !",
          body:
              "Jelajahi komunitas kami dan temukan teman-teman baru yang seru!",
          image: Image.asset(
            'assets/intro2.png',
            width: 340,
            height: 340,
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Mulai Upload status dan gambar kamu disini !",
          body: "Bagikan momen-momen berharga kamu dengan teman-teman di sini.",
          image: Image.asset(
            'assets/intro3.png',
            width: 440,
            height: 440,
            fit: BoxFit.cover,
          ),
        ),
      ],
      showSkipButton: true,
      skip: Text("Skip"),
    );
  }

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        bodyPadding: EdgeInsets.all(16)
            .copyWith(bottom: 20), // Sesuaikan nilai bottom sesuai kebutuhan
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.amber,
      );
}
