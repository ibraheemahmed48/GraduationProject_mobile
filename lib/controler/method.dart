import 'dart:typed_data';import 'package:cloud_firestore/cloud_firestore.dart';import 'package:dio/dio.dart';//import 'package:file_picker/file_picker.dart';import 'package:firebase_auth/firebase_auth.dart';import 'package:firebase_storage/firebase_storage.dart';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:fluttertoast/fluttertoast.dart';import 'package:get/get.dart';import 'package:image_gallery_saver/image_gallery_saver.dart';import 'package:notificationsystem_mobile/View/Login_page/login_main_page.dart';import 'package:permission_handler/permission_handler.dart';import 'package:top_snackbar_flutter/top_snack_bar.dart';//import 'package:mime_type/mime_type.dart';import '../View/home_page.dart';import '../help/Colors.dart';import '../help/text_style.dart';import 'Alerts.dart';import 'auth/auth.dart';class Methods {  static GlobalKey<FormState> formKey = GlobalKey<FormState>();  static List stagesUplode = ["First", "Second", "Third", "Fourth"];  static List stages = ["الاولى", "الثانية", "الثالثة", "الرابعة"];  /////////////////////////////////////////mobile///////// static RxList newsList = [].obs; static RxBool news_post =false.obs; static String Stagesfield=""; static String studentNmae="";  static String DocumentReference1="";  static String ImageURL="";  static String studentToken="";  static RxBool studendtext =false.obs;  //////////////// static RxList news_listfavoritesflag=[].obs; static RxList news_listlikesflag=[].obs; static RxList news_listdislikesflag=[].obs; /////////////  static void getNews1() async {    try {      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('News').where("Stages",arrayContains: "${Stagesfield}").get();      newsList = querySnapshot.docs.obs;      newsList.forEach((element) {        print("****************");        print(element.id);      });      Future.delayed(const Duration(seconds: 0), () async {        news_post.value=true;        for(var i = 0;i<Methods.newsList.length;i++){          news_listfavoritesflag.add(false);          news_listlikesflag.add(false);          news_listdislikesflag.add(false);        }      });    } catch (e) {      news_post.value=false;      print('Error retrieving data from Firestore: $e');    }  } static RxList Schedules_List = [].obs; static RxBool Schedules_post =false.obs; //////////////// static RxList Schedules_listfavoritesflag=[].obs; static RxList Schedules_listlikesflag=[].obs; static RxList Schedules_listdislikesflag=[].obs; ///////////// static void getSchedules() async {   try {     QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Schedules').where("Stages",isEqualTo: "$Stagesfield").get();     Schedules_List = querySnapshot.docs.obs;     Schedules_List.forEach((element) {       print("****************");       print(element);     });     Future.delayed(const Duration(seconds: 0), () async {       Schedules_post.value=true;       for(var i = 0;i<Methods.Schedules_List.length;i++){         Schedules_listfavoritesflag.add(false);         Schedules_listlikesflag.add(false);         Schedules_listdislikesflag.add(false);       }     });   } catch (e) {     Schedules_post.value=false;     print('Error retrieving data from Firestore: $e');   } }  ////////////////////////////////////////////////// static getHttp({required String url}) async {   var response = await Dio().get(       "$url",       options: Options(responseType: ResponseType.bytes));   final result = await ImageGallerySaver.saveImage(       Uint8List.fromList(response.data),       quality: 60,       name: "${DateTime.now().toString()}");   print(result["isSuccess"]);   if(result["isSuccess"]==true){     _toastInfo("تم الحفظ");   }else{     _toastInfo("حدث خطاً");   } } static _toastInfo(String info) {   Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_SHORT,backgroundColor: Colorsapp.Container_post,textColor: Colorsapp.mainColor); } static requestPermission() async {   Map<Permission, PermissionStatus> statuses = await [     Permission.storage,   ].request();   final info = statuses[Permission.storage].toString();   print("///////////////////////////////");   print(info);   print("///////////////////////////////");    if(info == "PermissionStatus.granted"){      _toastInfo("تم الوصول الى الصور");    }else{      _toastInfo("حدث خطأ في الوصول");    } }  /////////////////////////////////////////mobile/////////  static bool passflgs = false;  static bool emailflgs = false;  static RxBool emailExists=false.obs;  //Methods.emailExists.value = await Methods.checkEmailExists(Stages.Email_signin.text);  static Future<bool> checkEmailExists(String email) async {    print("////////////////checkEmailExists/////////////////////////////");    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Student');    QuerySnapshot snapshot = await usersCollection.where('email', isEqualTo: email).get();    return snapshot.docs.isNotEmpty;  }  static RxBool LogInflag = false.obs;  static String stage = "";  static Future<void> signInWithEmailPassword(BuildContext context, {required String email, required String password} ) async {    DocumentReference1="";    stage = "";    studentNmae="";    try {      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(          email: email,          password: password)          .then((value) => {      });      var i = 0;      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance          .collection("Student")          .where('email', isEqualTo:email) // Replace 'field_name' with the name of your field, and 'search_value' with the value you want to search for          .get().whenComplete(() => {})          .catchError((error) {        print("Error111111111: $error");        Alerts.showAlerterror(            context, "اعد المحاولة");      });      querySnapshot.docs.forEach((doc) {        print("Uid   ${doc.id}");        print(" ${i}  ${doc["stage"]}");        print("DocumentReference: ${doc.id}");        Methods.stage = doc["stage"];        Methods.DocumentReference1=doc.id;        Methods.studentNmae = doc["name"];        //Methods.ImageURL=doc["imageUrl"];        // prints a map containing the fields of the document      });      if (stage ==stagesUplode[0]) {        Methods.Stagesfield = stages[0];      }      if (stage == stagesUplode[1]) {        Methods.Stagesfield = stages[1];      }      if (stage == stagesUplode[2]) {        Methods.Stagesfield =        stages[2];      }      if (stage ==          stagesUplode[3]) {        Methods.Stagesfield = stages[3];      }      print(" after Methods.Stagesfield  ${Methods.Stagesfield}");      UserPreferences.saveCredentials(email, password);      Get.off(HomePage(),transition: Transition.noTransition);//////////////////////////////////    } on FirebaseAuthException catch (e) {      if (e.code == 'user-not-found') {        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(          email: email,          password: '12345678',        );        await signInWithEmailPassword(context,email: email, password: '12345678');      } else if (e.code == 'wrong-password') {        Alerts.showAlerterror(            context, "الباسورد خطأ");        print(            'Wrong password provided for that user.');      } else {        Alerts.showAlerterror(            context, "اعد المحاولة");        print(e);      }    } catch (e) {      print(e);      Alerts.showAlerterror(          context, "اعد المحاولة");    }  }  static FirebaseFirestore Studentscontact = FirebaseFirestore.instance;  static Future<void> Student_text({required String studentName,required String text,required String stage}) async {    try {      await Studentscontact.collection('Studentscontact').add({        'student_name': studentName,        'text': text,        'stage': stage,      }).whenComplete(() => {      studendtext.value=false      });      print('Document added successfully!');    } catch (e) {      print('Error adding document: $e');      studendtext.value=true;    }  }  static Future<void> resetPassword(BuildContext context,String email) async {    try {      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);      print('Password reset email sent to $email');      Alerts.showAlertDONE(context, "تم ارسال الى الايميل");    } on FirebaseAuthException catch (e) {      if (e.code == 'user-not-found') {        Alerts.showAlerterror(context, "لا يوجد ايميل");      } else {        print(e);        Alerts.showAlerterror(context, "هناك خطأ");      }    } catch (e) {      Alerts.showAlerterror(context, "هناك خطأ");      print(e);    }  }  static Future addToken({required String documentId, required String token}) async {    try {      // Create a reference to the document you want to update.      DocumentReference documentReference = FirebaseFirestore.instance.collection('Student').doc(documentId);      // Update the document with the download URL.      await documentReference.update({        'Token': token,      });      // Display a success message.      print('Download Token added to document with ID: $documentId');    } catch (e) {      print('Error adding download URL to document: $e');    }  }  static Future<void> autosignInWithEmailPassword(BuildContext context, {required String email, required String password} ) async {    DocumentReference1="";    stage = "";    studentNmae="";    try {      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(          email: email,          password: password)          .then((value) => {      });      var i = 0;      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance          .collection("Student")          .where('email', isEqualTo:email) // Replace 'field_name' with the name of your field, and 'search_value' with the value you want to search for          .get().whenComplete(() => {})          .catchError((error) {        print("Error111111111: $error");      });      querySnapshot.docs.forEach((doc) {        print("Uid   ${doc.id}");        print(" ${i}  ${doc["stage"]}");        print("DocumentReference: ${doc.id}");        Methods.stage = doc["stage"];        Methods.DocumentReference1=doc.id;        Methods.studentNmae = doc["name"];        //Methods.ImageURL=doc["imageUrl"];        // prints a map containing the fields of the document      });      if (stage ==stagesUplode[0]) {        Methods.Stagesfield = stages[0];      }      if (stage == stagesUplode[1]) {        Methods.Stagesfield = stages[1];      }      if (stage == stagesUplode[2]) {        Methods.Stagesfield =        stages[2];      }      if (stage ==          stagesUplode[3]) {        Methods.Stagesfield = stages[3];      }      print(" after Methods.Stagesfield  ${Methods.Stagesfield}");      Get.off(HomePage(),transition: Transition.noTransition);//////////////////////////////////    } on FirebaseAuthException catch (e) {      if (e.code == 'user-not-found') {        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(          email: email,          password: '12345678',        );        Get.off(LogIn_Main_Page(),transition: Transition.noTransition);      } else if (e.code == 'wrong-password') {        print(            'Wrong password provided for that user.');        Get.off(LogIn_Main_Page(),transition: Transition.noTransition);      } else {        Get.off(LogIn_Main_Page(),transition: Transition.noTransition);      }    } catch (e) {      print("سششششششششششششششششش$e");    }  }}