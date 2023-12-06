part of "pages.dart";

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _loading = false;
  bool _isObscure = true;

  // final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlEmail = TextEditingController();

  final TextEditingController _ctrlPass = TextEditingController();
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void handleSubmit() async {
    final email = _ctrlEmail.value.text;
    final password = _ctrlPass.value.text;
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Semua field harus diisi');
      return;
    }

    setState(() => _loading = true);

    try {
      // Cobalah untuk melakukan login
      await AuthData().login(email, password);
      _showSnackBar("Proses login berhasil!");
      Provider.of<PageData>(context, listen: false).resetIndexPage();
      Duration(seconds: 1);
      Navigator.popAndPushNamed(context, "/");
    } catch (e) {
      print('Error: $e');
      _showSnackBar('Email atau password tidak valid');
    } finally {
      Duration(seconds: 1);
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _ctrlEmail.dispose();
    _ctrlPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Masuk",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Masuk ke akun kamu !",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _ctrlEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan Masukkan Email Anda';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                          labelText: "Email"),
                                                    onChanged: (value) {
                        setState(() {
                          _ctrlEmail.text = value.replaceAll(' ', '');
                          _ctrlEmail.text = value.toLowerCase();
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _ctrlPass,
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Silakan Masukkan Password Anda';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: ElevatedButton(
                    onPressed: () => handleSubmit(),
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text("Submit"),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, "/sign-up");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum Punya Akun ? ",
                      style: TextStyle(
                        color: Colors.grey[700], // Warna teks
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/sign-up");
                      },
                      child: Text(
                        "Daftar",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Warna teks
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 100),
                height: 200,
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/background.png"),
                    //   fit: BoxFit.fitHeight,
                    // ),
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputFile({
  label,
  obscureText = false,
  textColor = Colors.black, // Warna teks
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}
