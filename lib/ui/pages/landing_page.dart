// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

part of "pages.dart";

class landingPage extends StatelessWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Selamat Datang !",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
          SizedBox(height: 17),
          Text(
            "di Sosial Media Masa Depan",
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Image.asset(
            'assets/landing(1).png',
            width: 400,
            height: 380,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 70,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.pushNamed(context, "/sign-in");
                    },
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.pushNamed(context, "/sign-up");
                    },
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Daftar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
