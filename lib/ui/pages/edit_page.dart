part of "pages.dart";

class EditPage extends StatefulWidget {
  EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  UserAcc? user;
  bool _loading = false;
  String? _selectedGender;
  List<String> _genderOptions = ["Male", "Female", "Non"];

  String? _profileImagePath;
  String? _coverImagePath;
  String? url;
  int randomNumber = Random().nextInt(99999999 - 10000000 + 1) + 10000000;

  final FocusNode _focus = FocusNode();

  TextEditingController _ctrlNama = TextEditingController();
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlUsername = TextEditingController();
  TextEditingController _ctrlNomor = TextEditingController();

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
                              url ?? user?.sampul ?? "",
                              //_coverImagePath?.isNotEmpty ?? false ? url! : user?.sampul?? "",
                              width: lebar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            top: 50,
                            child: GestureDetector(
                              onTap: () {},
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 40.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() async {
                                _getFromGallery();
                                if (user?.foto != null) {
                                  Reference ref = FirebaseStorage.instance
                                      .ref()
                                      .child("users/$randomNumber.jpg");
                                  await ref.putFile(File(user!.foto!));
                                  url = await ref.getDownloadURL();
                                } else if (user?.sampul != null) {
                                  Reference ref = FirebaseStorage.instance
                                      .ref()
                                      .child("users/$randomNumber.jpg");
                                  await ref.putFile(File(_coverImagePath!));
                                  url = await ref.getDownloadURL();
                                }
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        size: 16,
                                      ),
                                      Text("  Ubah Sampul",
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontSize,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
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
                                user?.foto ?? "",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //     top: 180,
                        //     child: GestureDetector(
                        //       onTap: () {},
                        //     )),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 150.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(5),
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Theme.of(context)
                        //               .colorScheme
                        //               .primaryContainer,
                        //         ),
                        //         child: Icon(
                        //           Icons.edit,
                        //           color:
                        //               Theme.of(context).colorScheme.onPrimary,
                        //           size: 16,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                    //       child: ElevatedButton(
                    //         onPressed: () async {
                    //           _getFromGallery();
                    //           String id = FirebaseAuth.instance.currentUser!.uid;
                    //             if (user?.sampul != null) {
                    //               Reference ref = FirebaseStorage.instance
                    //                   .ref()
                    //                   .child("users/$id/sampul_$randomNumber.jpg");
                    //               await ref.putFile(File(user!.sampul!));
                    //               url = await ref.getDownloadURL();
                    //             }
                    //         },
                    //         child: Row(
                    //           children: [
                    //             Icon(Icons.edit),
                    //             SizedBox(width: 8),
                    //             Text("Ubah Sampul"),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Spacer(),
                    //     ElevatedButton(
                    //         onPressed: () {},
                    //         child: Row(
                    //           children: [
                    //             Icon(Icons.edit),
                    //             SizedBox(width: 8),
                    //             Text("Ubah Profil"),
                    //           ],
                    //         ),
                    //       ),
                    //   ],
                    // ),
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
                              String id =
                                  FirebaseAuth.instance.currentUser!.uid;
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
                                "foto": _profileImagePath == null
                                    ? url
                                    : user?.foto,
                                "sampul": _coverImagePath == null
                                    ? (url ??
                                        user?.sampul ??
                                        "") // Gunakan url jika sudah diambil dari Firebase Storage
                                    : url ??
                                        user?.sampul ??
                                        "", // Gunakan _coverImagePath jika tidak ada url dari Firebase Storage
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

  void _getFromGallery() async {
    XFile? pickedFile;
    try {
      pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    } catch (e) {
      print('Error picking image: $e');
    }

    if (pickedFile != null) {
      _profileImagePath = pickedFile.path;
      _coverImagePath = pickedFile.path;
      _focus.requestFocus();
    }
  }
}
