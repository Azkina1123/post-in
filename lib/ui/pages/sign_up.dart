part of "pages.dart";

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _loading = false;
  String? _selectedGender;
  bool _isObscure = true;
  List<String> _genderOptions = ["Male", "Female"];
  String? imgPath;
  String? _profileImagePath;
  String? _coverImagePath;
  String? urlProfile;
  String? urlSampul;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlNama = TextEditingController();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlUsername = TextEditingController();
  final TextEditingController _ctrlNomor = TextEditingController();
  final TextEditingController _ctrlPass = TextEditingController();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _getFromGalleryCover() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _coverImagePath = pickedFile.path;
        print("Cover Image Path: $_coverImagePath");
      });
    }
  }

  void _getFromGalleryProfile() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
        print("Cover Image Path: $_profileImagePath");
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Silakan Masukkan Email Anda';
    } else if (!EmailValidator.validate(value)) {
      return 'Email tidak valid';
    } else if (!value.endsWith('@gmail.com')) {
      return 'Email harus diakhiri dengan @gmail.com';
    }
    return null;
  }

  Future<bool> cekUsername() async {
    String username = _ctrlUsername.text;

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (query.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username Sudah Ada, Harap Memilih Username Lain"),
        ),
      );
      _ctrlUsername.text = user?.username ?? "";
      return false;
    } else {
      return true;
    }
  }

  // handleSubmit() async {
  //   // if (!_formKey.currentState!.validate()) return;
  //   final nama = _ctrlNama.value.text;
  //   final email = _ctrlEmail.value.text;
  //   final username = _ctrlUsername.value.text;
  //   final password = _ctrlPass.value.text;
  //   final gender = _selectedGender;
  //   final nomor = _ctrlNomor.value.text;

  //   if (nama.isEmpty ||
  //       email.isEmpty ||
  //       username.isEmpty ||
  //       password.isEmpty ||
  //       gender == null ||
  //       nomor.isEmpty ||
  //       _profileImagePath == null ||
  //       _coverImagePath == null) {
  //     _showSnackBar('Semua field harus diisi');
  //     return;
  //   }
  //   if (password.length < 6) {
  //     _showSnackBar('Isi Password minimal 6 karakter');

  //     String? profileImagePath = _profileImagePath;
  //     String? coverImagePath = _coverImagePath;

  //     return;
  //   }
  //   setState(() => _loading = true);
  //   await AuthData().regis(nama, email, username, password, gender, nomor,
  //       _profileImagePath, _coverImagePath);

  //   setState(() => _loading = false);
  // }

  handleSubmit() async {
    // if (!_formKey.currentState!.validate()) return;
    final nama = _ctrlNama.value.text;
    final email = _ctrlEmail.value.text;
    final username = _ctrlUsername.value.text;
    final password = _ctrlPass.value.text;
    final gender = _selectedGender;
    final nomor = _ctrlNomor.value.text;

    if (nama.isEmpty ||
        email.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        gender == null ||
        nomor.isEmpty ||
        _profileImagePath == null ||
        _coverImagePath == null) {
      _showSnackBar('Semua field harus diisi');
      return;
    }
    if (password.length < 6) {
      _showSnackBar('Isi Password minimal 6 karakter');

      String? profileImagePath = _profileImagePath;
      String? coverImagePath = _coverImagePath;

      return;
    }
    setState(() => _loading = true);
    await AuthData().regis(nama, email, username, password, gender, nomor,
        _profileImagePath, _coverImagePath);
    _showSnackBar('Proses registrasi berhasil!');
    Navigator.popAndPushNamed(context, "/sign-in");

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
        const SizedBox(height: 20),
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
            Navigator.popAndPushNamed(context, "/landing");
          },
          icon: Icon(Icons.arrow_back,
              size: 25, color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
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
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nama Lengkap',
                          labelText: "Nama Lengkap",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlUsername,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Username Anda';
                            } else if (value.contains(' ')) {
                              return "Username Tidak Boleh Mengandung Spasi !";
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _ctrlUsername.text = value.replaceAll(' ', '');
                              _ctrlUsername.text = value.toLowerCase();
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Username',
                          labelText: "Username",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlEmail,
                          validator: _validateEmail,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(30),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          labelText: "Email",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedGender,
                          items: _genderOptions.map((String gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Gender',
                          labelText: "Gender",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(13),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Nomor Telepon',
                          labelText: "Nomor Telepon",
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _ctrlPass,
                          obscureText: _isObscure,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Silakan Masukkan Password Anda';
                            }
                            return null;
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25),
                          ],
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _profileImagePath != null ? Image.file(File(_profileImagePath!), width: 100, height: 100, fit: BoxFit.cover, ) :  const SizedBox(
                          height: 0,
                        ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          _getFromGalleryProfile();
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.upload),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Upload foto Profil"),
                          ],
                        ),
                      )),
                    ],
                  ),
                  const SizedBox(height: 5),
                                    _coverImagePath != null
                      ? Image.file(
                          File(_coverImagePath!),
                          width: width(context),
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(height: 0,),

                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () async {
                          _getFromGalleryCover();
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.upload),
                            SizedBox(
                              width: 8,
                            ),
                            Text("Upload foto Sampul"),
                          ],
                        ),
                      )),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
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
                        : const Text("Daftar"),
                  ),
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
