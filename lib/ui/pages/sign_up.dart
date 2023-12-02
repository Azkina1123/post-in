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
  List<String> _genderOptions = ["Male", "Female", "Non"];
  String? _profileImagePath;
  String? _coverImagePath;
  String? imgPath;

  // String? _profileImagePath;
  // String? _coverImagePath;
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

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imgPath = pickedFile.path;
    }
  }
  //   Future<void> uploadImage() async {
  //   try {
  //     final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

  //     if (pickedFile != null) {
  //       setState(() {
  //         _profileImagePath = pickedFile.path;
  //       });

  //       // Assuming you have a unique identifier like `randomNumber` for the image file
  //       String randomNumber = "your_unique_identifier_here";

  //       Reference ref = FirebaseStorage.instance.ref().child("posts/$randomNumber.jpg");
  //       await ref.putFile(File(pickedFile.path));
  //       String url = await ref.getDownloadURL();

  //       // You can use the `url` for further processing if needed
  //       print("Image uploaded successfully. Download URL: $url");
  //     }
  //   } catch (e) {
  //     print("Error uploading image: $e");
  //   }
  // }

  handleSubmit() async {
    // if (!_formKey.currentState!.validate()) return;
    final nama = _ctrlNama.value.text;
    final email = _ctrlEmail.value.text;
    final username = _ctrlUsername.value.text;
    final password = _ctrlPass.value.text;
    final gender = _selectedGender ?? "";
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

      //    try {
      //   // Upload profile image
      //   Reference profileImageRef = FirebaseStorage.instance
      //       .ref()
      //       .child("profile_images/$randomprofileimage.jpg");
      //   await profileImageRef.putFile(File(_profileImagePath!));
      //   String profileImageUrl = await profileImageRef.getDownloadURL();

      //     if (coverImagePath != null) {
      //       Reference ref = FirebaseStorage.instance
      //           .ref()
      //           .child("cover_images/$randomcoverimage.jpg");
      //       await ref.putFile(File(coverImagePath));
      //       coverImagePath = await ref.getDownloadURL();
      //     }
      //     setState(() => _loading = false);
      //     return;
      //   }

      //   setState(() => _loading = true);
      //   await AuthData().regis(nama, email, username, password, gender, nomor,
      //       _profileImagePath, _coverImagePath);

      //   setState(() => _loading = false);
      // }

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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(40),
                              ],
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20),
                              ],
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Email',
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
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
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(13),
                              ],
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
                                border: OutlineInputBorder(),
                                hintText: 'Password',
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
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _getFromGallery();
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.upload),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("Upload foto Profil"),
                              ],
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _getFromGallery();
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.upload),
                                const SizedBox(
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
