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
  List<String> _genderOptions = ["Male", "Female", "Non"];

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
      _coverImagePath = pickedFile.path;
      print("Cover Image Path: $_coverImagePath");
    }
  }

  void _getFromGalleryProfile() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      _profileImagePath = pickedFile.path;
      print("Cover Image Path: $_profileImagePath");
    }
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,
              size: 25, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: ListView(children: [
        FutureBuilder<UserAcc>(
          future: Provider.of<UserData>(context, listen: false)
              .getUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              user = snapshot.data!;
            } else {
              return Container(
                width: width(context),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
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
                            child: Image.network(
                              urlSampul ?? user?.sampul ?? "",
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
                              child: Image.network(
                                urlProfile ?? user?.foto ?? "",
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
                              hintText: user?.namaLengkap ?? "",
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(40),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _ctrlEmail,
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: user?.email ?? "",
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _ctrlUsername,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: user?.username ?? "",
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(20),
                            ],
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
                              _selectedGender = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: user?.gender ?? "",
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
                            ),
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
                            onPressed: () async {
                              String id =
                                  FirebaseAuth.instance.currentUser!.uid;

                              await cekUsername();

                              if (_coverImagePath != null) {
                                Reference refSampul = FirebaseStorage.instance
                                    .ref()
                                    .child("users/sampul_$id.jpg");
                                await refSampul.putFile(File(_coverImagePath!));
                                urlSampul = await refSampul.getDownloadURL();
                              }

                              if (_profileImagePath != null) {
                                Reference refProfile = FirebaseStorage.instance
                                    .ref()
                                    .child("users/profile_$id.jpg");
                                await refProfile
                                    .putFile(File(_profileImagePath!));
                                urlProfile = await refProfile.getDownloadURL();
                              }

                              Map<String, dynamic> updateProfile = {};

                              users.doc(id).update({
                                "namaLengkap": _ctrlNama.text.isEmpty
                                    ? user?.namaLengkap
                                    : _ctrlNama.text.toString(),
                                "username": _ctrlUsername.text.isEmpty
                                    ? user?.username
                                    : _ctrlUsername.text.toString(),
                                "gender": _selectedGender!.isEmpty
                                    ? user?.gender
                                    : _selectedGender,
                                "noTelp": _ctrlNomor.text.isEmpty
                                    ? user?.noTelp
                                    : _ctrlNomor.text.toString(),
                                "foto": urlProfile != null
                                    ? urlProfile
                                    : user?.foto,
                                "sampul": urlSampul != null
                                    ? urlSampul
                                    : user?.sampul,
                              });

                              Navigator.of(context).pop();
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
            );
          },
        ),
      ]),
    );
  }

  Future<void> cekUsername() async {
    String username = _ctrlUsername.text;

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (query.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username Tidak Diterima, Perubahan Username Dibatalkan"),
        ),
      );
      _ctrlUsername.text = user?.username ?? "";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username Tersedia dan Berhasil Diubah"),
        ),
      );
    }
  }
}
