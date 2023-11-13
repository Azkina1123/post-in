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
    // TODO: implement initState
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

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: width(context),
          height: _focus.hasFocus ? 120 : 70,
          padding: const EdgeInsets.only(left: 15, right: 20, bottom: 10),
          margin: const EdgeInsets.only(top: 20),

          // isian postingan ---------------------------------------------------------
          child: Focus(
            // focusNode: _focus,
            onFocusChange: (hasFocus) {
              Provider.of<PageData>(context, listen: false).changeKomentarFocus(_focus.hasFocus);
              // setState(() {});
            },
            child: TextField(
              focusNode: _focus,
              // autofocus: ,
              decoration: InputDecoration(
                hintText: "Bagikan komentar Anda!",
                icon: AccountButton(
                  image: NetworkImage(Provider.of<AuthData>(context, listen: false)
                      .authUser
                      .foto!),
                  onPressed: null,
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 5,
              controller: _kontenCon,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
        if (_kontenCon.text.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            // alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _kontenCon.text.isNotEmpty
                      ? () async {
                          Provider.of<KomentarData>(context, listen: false)
                              .addKomentar(
                            Komentar(
                              id: 1,
                              tglDibuat: DateTime.now(),
                              konten: _kontenCon.text,
                              totalLike: 0,
                              postId: widget.post.id,
                              userId: Provider.of<AuthData>(
                                context,
                                listen: false,
                              ).authUser.id,
                            ),
                          );
                          Provider.of<PostData>(context, listen: false)
                              .updateTotalKomentarPost(
                            widget.post.idDoc!,
                            widget.post.totalKomentar + 1,
                          );
                          _focus.unfocus();
                          _kontenCon.clear();
                        }
                      : null,
                  // style: ,
                  child: const Text("Kirim"),
                ),
              ],
            ),
          )
      ],
    );
  }
}
