part of "widgets.dart";

class InputPost extends StatefulWidget {
  int tabIndex;
  InputPost({super.key, required this.tabIndex});
  @override
  State<InputPost> createState() => _InputPostState();
}

class _InputPostState extends State<InputPost> {
  final TextEditingController _kontenCon = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _focused = false;
  String? imgPath;

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
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          margin: EdgeInsets.only(top: 20),

          // isian postingan ---------------------------------------------------------
          child: Focus(
            // focusNode: _focus,
            onFocusChange: (hasFocus) {
              setState(() {
                _focused = hasFocus;
              });
            },
            child: TextField(
              focusNode: _focus,
              autofocus: imgPath != null ? true : false,
              decoration: InputDecoration(
                hintText: "Ceritakan kisah Anda hari ini!",
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
            padding: EdgeInsets.only(left: 20, right: 20),
            // alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (imgPath != null)
                  GestureDetector(
                    onLongPress: () {
                      setState(() {
                        imgPath = null;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(
                            File(imgPath!),
                          ),
                        ),
                      ),
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _getFromGallery();
                    });
                  },
                  icon: Icon(Icons.image),
                  iconSize: 40,
                ),
                ElevatedButton(
                  onPressed: _kontenCon.text.isNotEmpty
                      ? () {
                          Provider.of<PostData>(context, listen: false).addPost(
                            Post(
                              id: 1,
                              tglDibuat: DateTime.now(),
                              konten: _kontenCon.text,
                              userId:
                                  Provider.of<AuthData>(context, listen: false)
                                      .authUser
                                      .id,
                              img: imgPath,
                              totalKomentar: 0,
                              totalLike: 0,
                            ),
                          );
                          _focus.unfocus();
                          _kontenCon.clear();
                        }
                      : null,
                  // style: ,
                  child: Text("Posting"),
                ),
              ],
            ),
          )
      ],
    );
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imgPath = pickedFile.path;
      _focus.requestFocus();
    }
  }
}
