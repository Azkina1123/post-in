part of "widgets.dart";

class InputKomentar extends StatefulWidget {
  Post post;
  InputKomentar({super.key, required this.post});
  @override
  State<InputKomentar> createState() => _InputKomentarState();
}

class _InputKomentarState extends State<InputKomentar> {
  TextEditingController _kontenCon = TextEditingController();
  bool _focused = false;
  FocusNode _focus = FocusNode();

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

    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: width(context),
          height: _focused ? 120 : 70,
          padding: EdgeInsets.only(left: 15, right: 20, bottom: 10),
          margin: EdgeInsets.only(top: 20),

          // isian postingan ---------------------------------------------------------
          child: Focus(
            // focusNode: _focus,
            onFocusChange: (hasFocus) {
              setState(() {
                
                // Provider.of<PageProvider>(context).changeKomentarFocus(
                //   !Provider.of<PageProvider>(context).komentarFocused,
                // );
                _focused = hasFocus;
              });
            },
            child: TextField(
              focusNode: _focus,
              // autofocus: ,
              decoration: InputDecoration(
                hintText: "Bagikan komentar Anda!",
                icon: AccountButton(
                  image: Provider.of<AuthProvider>(context, listen: false)
                      .authUser
                      .foto!,
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
        if (_focused)
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            // alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _kontenCon.text.isNotEmpty
                      ? () {
                          Provider.of<KomentarProvider>(context, listen: false)
                              .addKomentar(
                            Komentar(
                              id: Provider.of<KomentarProvider>(
                                    context,
                                    listen: false,
                                  ).komentarCount +
                                  1,
                              tglDibuat: DateTime.now(),
                              konten: _kontenCon.text,
                              postId: widget.post.id,
                              userId: Provider.of<AuthProvider>(
                                context,
                                listen: false,
                              ).authUser.id,
                            ),
                          );
                          _focus.unfocus();
                          _kontenCon.clear();
                        }
                      : null,
                  // style: ,
                  child: Text("Kirim"),
                ),
              ],
            ),
          )
      ],
    );
  }
}
