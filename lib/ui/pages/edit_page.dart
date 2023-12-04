part of "pages.dart";

class EditPage extends StatefulWidget {
  EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  UserAcc? user;
  bool _loading = false;
  bool _isUsernameAvailable = true;
  String? _selectedGender;
  List<String> _genderOptions = ["Male", "Female"];

  String? _profileImagePath;
  String? _coverImagePath;
  String? urlProfile;
  String? urlSampul;

  TextEditingController _ctrlNama = TextEditingController();
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlUsername = TextEditingController();
  TextEditingController _ctrlNomor = TextEditingController();

  void _getFromGalleryCover() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _coverImagePath = pickedFile.path;
      });
      print("Cover Image Path: $_coverImagePath");
    }
  }

  void _getFromGalleryProfile() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImagePath = pickedFile.path;
      });
      print("Cover Image Path: $_profileImagePath");
    }
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    UserAcc user = ModalRoute.of(context)!.settings.arguments as UserAcc;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, "/");
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: lebar,
                    height: 110,
                    child: ClipRRect(
                      child: _coverImagePath != null
                          ? Image.file(
                              File(_coverImagePath!),
                              width: lebar,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              user?.sampul ?? "",
                              width: lebar,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.background,
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _profileImagePath != null
                            ? Image.file(
                                File(_profileImagePath!),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                user.foto ?? "",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _ctrlNama,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: user.namaLengkap ?? "",
                        labelText: "Nama Lengkap"
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                      ],
                      onChanged: (value) {
                        setState(() {
                          
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _ctrlEmail,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: user.email,
                        labelText: "Email"
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _ctrlUsername,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: user.username,
                        labelText: "Username",
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _ctrlUsername.text = value.toLowerCase();
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
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
                        hintText: user.gender,
                        labelText: "Gender",
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _ctrlNomor,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(13),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: user?.noTelp ?? "",
                        labelText: "Nomor Telepon"
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        _getFromGalleryCover();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload),
                          SizedBox(width: 8),
                          Text("Ubah Sampul"),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        _getFromGalleryProfile();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload),
                          SizedBox(width: 8),
                          Text("Ubah Foto Profil"),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: isEmpty()
                          ? null
                          : () async {
                              String id =
                                  FirebaseAuth.instance.currentUser!.uid;

                              if (_coverImagePath != null) {
                                Reference refSampul = FirebaseStorage.instance
                                    .ref()
                                    .child("users/sampul_$id.jpg");
                                await refSampul.putFile(File(_coverImagePath!));
                                urlSampul = await refSampul.getDownloadURL();
                              } else {
                                urlSampul = user.sampul;
                              }

                              if (_profileImagePath != null) {
                                Reference refProfile = FirebaseStorage.instance
                                    .ref()
                                    .child("users/profile_$id.jpg");
                                await refProfile
                                    .putFile(File(_profileImagePath!));
                                urlProfile = await refProfile.getDownloadURL();
                              } else {
                                urlProfile = user.foto;
                              }

                              if (_selectedGender != null) {
                                user.gender = _selectedGender!;
                              }

                              if (!await cekUsername()) {
                                users.doc(id).update({
                                  "namaLengkap": _ctrlNama.text.isEmpty
                                      ? user.namaLengkap
                                      : _ctrlNama.text.toString(),
                                  "username": _ctrlUsername.text.isEmpty
                                      ? user.username.toLowerCase()
                                      : _ctrlUsername.text
                                          .toString()
                                          .toLowerCase(),
                                  "gender": user.gender,
                                  "noTelp": _ctrlNomor.text.isEmpty
                                      ? user.noTelp
                                      : _ctrlNomor.text.toString(),
                                  "foto": urlProfile,
                                  "sampul": urlSampul,
                                });

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Informasi",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                        ),
                                      ),
                                      content: Text(
                                        "Perubahan Berhasil Dilakukan",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .fontSize,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.popAndPushNamed(
                                                context, "/");
                                          },
                                          child: Text("Oke"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                      child: _loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text("Simpan Perubahan"),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  bool isEmpty() {
    if (_ctrlNama.text.isEmpty &&
        _ctrlUsername.text.isEmpty &&
        _ctrlNomor.text.isEmpty &&
        _coverImagePath == null &&
        _profileImagePath == null &&
        _selectedGender == null) {
      return true;
    }
    return false;
  }

  Future<bool> cekUsername() async {
    if (_ctrlUsername.text.isNotEmpty) {
      String username = _ctrlUsername.text;

      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (query.docs.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Username Tidak Diterima, Perubahan Username Dibatalkan"),
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Username Tersedia dan Berhasil Diubah"),
          ),
        );
        return false;
      }
    }
    return false;
  }
}
