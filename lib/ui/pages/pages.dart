import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:post_in/providers/providers.dart';
import 'package:post_in/ui/widgets/widgets.dart';
import 'package:post_in/models/models.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'main_page.dart';
part 'home_page.dart';
part 'cari_page.dart';
part 'pengaturan_page.dart';
part 'profile_page.dart';
part 'post_page.dart';
part 'introduction_page.dart';
part 'landing_page.dart';
part 'sign_in.dart';
part 'sign_up.dart';
part 'debugPage.dart';
part 'follow_page.dart';



// KomentarWidget(
//                                 komentar: Komentar(
//                                   id: e.get("id"), 
//                                   tglDibuat: e.get("tglDibuat"), 
//                                   konten: e.get("konten"), 
//                                   postId: e.get("postId"), 
//                                   userId: e.get("userId"),
//                                   ),
//                               ),