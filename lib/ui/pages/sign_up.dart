part of "pages.dart";

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlNama = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlGender = TextEditingController();
  final TextEditingController _ctrlNomor = TextEditingController();
  final TextEditingController _ctrlPass = TextEditingController();

  handleSubmit() async {
    // if (!_formKey.currentState!.validate()) return;
    final nama = _ctrlNama.value.text;
    final email = _ctrlEmail.value.text;
    final username = _ctrlUsername.value.text;
    final password = _ctrlPass.value.text;
    final gender = _ctrlGender.value.text;
    final nomor = _ctrlNomor.value.text;
    setState(() => _loading = true);
    await Auth().regis(nama, email, username, password, gender, nomor);
    setState(() => _loading = false);
  }

  Widget buttonUpload(
    String label,
    IconData icon,
    Function() onPressed,
  ) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,
              size: 25, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Buat Akun kamu disini !",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlNama,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Nama lengkap Anda';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nama Lengkap',
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlUsername,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Username Anda';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Username',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
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
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlGender,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Gender Anda';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Gender',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlNomor,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Nomor Anda';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nomor Telepon',
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlPass,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Password Anda';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: buttonUpload(
                          "Upload Foto Profil",
                          Icons.upload,
                          () {},
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: buttonUpload(
                          "Upload Sampul",
                          Icons.upload,
                          () {},
                        ),
                      ),
                    ],
                  ),
                ],
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
                        : Text("Daftar"),
                  ),
                  // MaterialButton(
                  //   minWidth: double.infinity,
                  //   height: 60,
                  //   onPressed: () {
                  //     // Navigator.popAndPushNamed(context, "/sign-in");

                  //   },
                  //   color: Theme.of(context).colorScheme.primary,
                  //   elevation: 0,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(50),
                  //   ),
                  //   child: Text(
                  //     "Daftar",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 18,
                  //       color: Theme.of(context).colorScheme.onSecondary,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah Punya Akun ? ",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/sign-in");
                    },
                    child: Text(
                      "Masuk",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
