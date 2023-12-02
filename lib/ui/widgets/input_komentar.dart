part of "widgets.dart";

class InputKomentar extends StatefulWidget {
  Post post;
  InputKomentar({super.key, required this.post});
  @override
  State<InputKomentar> createState() => _InputKomentarState();
}

class _InputKomentarState extends State<InputKomentar> {
  final TextEditingController _kontenCon = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _kontenCon.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<PageData>(context).komentarFocused) {
      _focus.requestFocus();
    } else {
      _focus.unfocus();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder<UserAcc>(
          future: Provider.of<UserData>(context, listen: false)
              .getUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserAcc authUser = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Focus(
                  // focusNode: _focus,
                  onFocusChange: (hasFocus) {
                    Provider.of<PageData>(context, listen: false)
                        .changeKomentarFocus(_focus.hasFocus);
                  },
                  child: TextField(
                    focusNode: _focus,
                    // autofocus: ,
                    decoration: InputDecoration(
                      hintText: "Bagikan komentar Anda!",
                      icon: AccountButton(
                        image: NetworkImage(
                          authUser.foto!,
                        ),
                        onPressed: null,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    controller: _kontenCon,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 5,),
                if (_kontenCon.text.isNotEmpty)
                  ElevatedButton(
                    onPressed: _kontenCon.text.isNotEmpty && !isSpace(_kontenCon.text)
                        ? () async {
                            final komentarData =
                                Provider.of<KomentarData>(context,
                                    listen: false);
                            // tambahkan komentar
                            komentarData.add(
                              Komentar(
                                id: "",
                                tglDibuat: DateTime.now(),
                                konten: _kontenCon.text,
                                postId: widget.post.id,
                                userId: authUser.id,
                              ),
                            );
                              _focus.unfocus();
                              _kontenCon.clear();
                          }
                        : null,
                    // style: ,
                    child: const Text("Kirim"),
                  )
              ]);
            }
            return const Text("");
          }),
    );
  }
  bool isSpace(String str) {
    return str.trim().isEmpty;
  }
}
