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

  // String? _profileImagePath;
  // String? _coverImagePath;

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: width(context),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
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
                              user?.sampul ?? "",
                              width: lebar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Positioned(
                        //     top: 50,
                        //     child: GestureDetector(
                        //       onTap: () {},
                        //     )),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 20.0, top: 40.0),
                        //   child: Row(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(5),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           border: Border.all(
                        //             color: Theme.of(context)
                        //                 .colorScheme
                        //                 .primaryContainer,
                        //             width: 2,
                        //           ),
                        //         ),
                        //         child: Row(
                        //           children: [
                        //             Icon(
                        //               Icons.edit,
                        //               color: Theme.of(context)
                        //                   .colorScheme
                        //                   .onPrimary,
                        //               size: 16,
                        //             ),
                        //             Text("  Ubah Sampul",
                        //                 style: TextStyle(
                        //                   fontSize: Theme.of(context)
                        //                       .textTheme
                        //                       .titleSmall!
                        //                       .fontSize,
                        //                   color: Theme.of(context)
                        //                       .colorScheme
                        //                       .onPrimary,
                        //                 ))
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
                        //             color: Theme.of(context)
                        //                 .colorScheme
                        //                 .primaryContainer,
                          
                        //         ),
                        //         child: Icon(
                        //           Icons.edit,
                        //           color: Theme.of(context)
                        //               .colorScheme
                        //               .onPrimary,
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
                    //         onPressed: () {},
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
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _ctrlEmail,
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: user?.email ?? "",
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _ctrlUsername,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: user?.username ?? "",
                            ),
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
                              FilteringTextInputFormatter.digitsOnly
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
                                      ? user!.namaLengkap
                                      : _ctrlNama.text.toString(),
                                  "username": _ctrlUsername.text.isEmpty
                                      ? user!.username
                                      : _ctrlUsername.text.toString(),
                                  "gender": _selectedGender!.isEmpty
                                      ? user!.gender
                                      : _selectedGender,
                                  "noTelp": _ctrlNomor.text.isEmpty
                                      ? user!.noTelp
                                      : _ctrlNomor.text.toString(),
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
}
