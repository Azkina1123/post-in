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
  final _formKey = GlobalKey<FormState>();

  TextEditingController _ctrlNama = TextEditingController();
  TextEditingController _ctrlEmail = TextEditingController();
  TextEditingController _ctrlUsername = TextEditingController();
  TextEditingController _ctrlNomor = TextEditingController();
  TextEditingController _ctrlPass = TextEditingController();

  // void setInitialValues() {
  //   _ctrlNama.text = user?.namaLengkap ?? "";
  //   _ctrlEmail.text = user?.email ?? "";
  //   _ctrlUsername.text = user?.username ?? "";
  //   _ctrlNomor.text = user?.noTelp ?? "";
  //   _selectedGender = user?.gender ?? "";
  //   _ctrlPass.text = user?.password ?? "";
  // }

  // handleSubmit() async {
  //   // if (!_formKey.currentState!.validate()) return;
  //   final nama = _ctrlNama.value.text;
  //   final email = _ctrlEmail.value.text;
  //   final username = _ctrlUsername.value.text;
  //   final password = _ctrlPass.value.text;
  //   final gender = _selectedGender ?? "";
  //   final nomor = _ctrlNomor.value.text;

  //   setState(() => _loading = true);
  //   await AuthData().regis(nama, email, username, password, gender, nomor);

  //   setState(() => _loading = false);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   setInitialValues();
  // }

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
              // _ctrlNama.text = _ctrlNama.text.isEmpty ? user?.namaLengkap ?? "": _ctrlNama.text;
              // _ctrlEmail.text = _ctrlEmail.text.isEmpty ? user?.email ?? "": _ctrlEmail.text;
              // _ctrlUsername.text = _ctrlUsername.text.isEmpty ? user?.username ?? "": _ctrlUsername.text;
              // _ctrlNomor.text = _ctrlNomor.text.isEmpty ? user?.noTelp ?? "": _ctrlNomor.text;
              // _selectedGender = _selectedGender!.isEmpty ? user?.gender ?? "": _selectedGender;
              // _ctrlPass.text = _ctrlPass.text.isEmpty ? user?.password ?? "": _ctrlPass.text;
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
                        ClipRRect(
                          child: Image.network(
                            user?.sampul ?? "",
                            width: lebar,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 140,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.background,
                                width: 5,
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
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: _ctrlEmail,
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
                              setState(() {
                                _selectedGender = value;
                              });
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
                              setState(() async {
                                String id =
                                  FirebaseAuth.instance.currentUser!.uid;
                              users.doc(id).update({
                                "namaLengkap": _ctrlNama.text.isEmpty ? user!.namaLengkap : _ctrlNama.text.toString(),
                                "email": _ctrlEmail.text.isEmpty ? user!.email : _ctrlEmail.text.toString(),
                                "username": _ctrlUsername.text.isEmpty ? user!.username : _ctrlUsername.text.toString(),
                                "gender": _selectedGender!.isEmpty ? user!.gender : _selectedGender,
                                "noTelp": _ctrlNomor.text.isEmpty ? user!.noTelp : _ctrlNomor.text.toString(),
                              });

                              //FirebaseAuth
                              await FirebaseAuth.instance.currentUser!
                                  .updateDisplayName(_ctrlNama.text.toString());
                              await FirebaseAuth.instance.currentUser!
                                  .updateEmail(_ctrlEmail.text.toString());
                              //await FirebaseAuth.instance.currentUser!.updatePhoneNumber(_ctrlNomor.text.toString());
                              });
                              
                              Navigator.popAndPushNamed(context, "/pengaturan");
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
