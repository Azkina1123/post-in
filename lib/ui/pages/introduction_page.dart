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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return landingPage();
            },
          ),
        );
      },
      pages: [
        PageViewModel(
          title: " HALOOO !",
          body:
              "Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum",
          image: Image.asset(
            'assets/landing(1).png',
            width: 480,
            height: 480,
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Temukan Teman baru kalian disini !",
          body:
              "Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum",
          image: Image.asset(
            'assets/landing(1).png',
            width: 480,
            height: 480,
            fit: BoxFit.cover,
          ),
        ),
        PageViewModel(
          title: "Mulai Upload status dan gambar kamu disini !",
          body:
              "Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum Lorem ipsum lorem ipsum",
          image: Image.asset(
            'assets/landing(1).png',
            width: 480,
            height: 480,
            fit: BoxFit.cover,
          ),
        ),
      ],
      showSkipButton: true,
      skip: Text("skip"),
    );
  }

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        bodyPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        pageColor: Colors.amber,
      );
}
