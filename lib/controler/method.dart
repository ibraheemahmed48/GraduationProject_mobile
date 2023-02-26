import 'dart:typed_data';import 'package:cloud_firestore/cloud_firestore.dart';import 'package:dio/dio.dart';//import 'package:file_picker/file_picker.dart';import 'package:firebase_auth/firebase_auth.dart';import 'package:firebase_storage/firebase_storage.dart';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:fluttertoast/fluttertoast.dart';import 'package:get/get.dart';import 'package:image_gallery_saver/image_gallery_saver.dart';import 'package:permission_handler/permission_handler.dart';//import 'package:mime_type/mime_type.dart';import '../help/Colors.dart';import '../help/text_style.dart';import 'model.dart';class Methods {  /////////////////////////////////////////mobile///////// static RxList newsList = [].obs; static RxBool post =false.obs; static String Stagesfield =""; //////////////// static RxList listfavoritesflag=[].obs; static RxList listlikesflag=[].obs; static RxList listdislikesflag=[].obs; /////////////  static void getNews1() async {    Stagesfield = Stages.stages[3];    try {      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('News').where("Stages",arrayContains: "${Stagesfield}").get();      newsList = querySnapshot.docs.obs;      newsList.forEach((element) {        print("****************");        print(newsList[0].id);      });      Future.delayed(const Duration(seconds: 2), () async {        post.value=true;        for(var i = 0;i<Methods.newsList.length;i++){          listfavoritesflag.add(false);          listlikesflag.add(false);          listdislikesflag.add(false);        }      });    } catch (e) {      post.value=false;      print('Error retrieving data from Firestore: $e');    }  } static getHttp({required String url}) async {   var response = await Dio().get(       "$url",       options: Options(responseType: ResponseType.bytes));   final result = await ImageGallerySaver.saveImage(       Uint8List.fromList(response.data),       quality: 60,       name: "${DateTime.now().toString()}");   print(result["isSuccess"]);   if(result["isSuccess"]==true){     _toastInfo("تم الحفظ");   }else{     _toastInfo("حدث خطاً");   } } static _toastInfo(String info) {   Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_SHORT,backgroundColor: Colorsapp.Container_post,textColor: Colorsapp.mainColor); } static requestPermission() async {   Map<Permission, PermissionStatus> statuses = await [     Permission.storage,   ].request();   final info = statuses[Permission.storage].toString();   print("///////////////////////////////");   print(info);   print("///////////////////////////////");    if(info == "PermissionStatus.granted"){      _toastInfo("تم الوصول الى الصور");    }else{      _toastInfo("حدث خطأ في الوصول");    } }  /////////////////////////////////////////mobile/////////  static bool passflgs = false;  static bool emailflgs = false;//   static Signin({required email ,required passowrd}) async {//     try {//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(//           email: email,//           password: passowrd//       );//       passflgs = false;//       emailflgs = false;//////     } on  FirebaseAuthException catch (e) {//       if (e.code == 'user-not-found') {//         Stages.finaltext ="لا يوجد حساب";//         passflgs = true;//       } else if (e.code == 'wrong-password') {//         Stages.finaltext ="الباسورد خطأ";//         passflgs = true;////       }//     }// } //  static CollectionReference News = FirebaseFirestore.instance.collection("News"); // static RxList newsList = [].obs; //  static RxBool post =false.obs; // //  static getNews() async { //    newsList = [].obs; //    QuerySnapshot query = await News.get().whenComplete(() => { //      post.value=true //    }); //    newsList = query.docs.obs; //    newsList.forEach((element) { //    print("****************"); // //    print(newsList[0].id); //    }); //  }//////////////////////////////Schedules/////////  static CollectionReference Schedules = FirebaseFirestore.instance.collection("Schedules");  static RxList SchedulessList = [].obs;  static RxBool Schedulespost =false.obs;  static getSchedules() async {    SchedulessList = [].obs;    QuerySnapshot query = await Schedules.get().whenComplete(() => {      Schedulespost.value=true    });    SchedulessList = query.docs.obs;    SchedulessList.forEach((element) {      print("****************");      print(SchedulessList[0].id);    });  }  //  // static upLodeImagesnew({required text}) async {  //   Stages.urlNewsImage="";  //   Stages.flagsNews.value =false;  //  //   final result = await FilePicker.platform.pickFiles(  //     type: FileType.image,  //   );  //  //  //  //   if (result != null) {  //     var mimeType = mime(result.files.single.name);  //  //  //  //     final file =await result.files.single.bytes;  //     Stages.bytesData1 = file;  //     var ref = FirebaseStorage.instance.ref("${text}Images").child("${DateTime.now().toString()+result.files.single.name}");  //     await ref.putData(file!,SettableMetadata(contentType: mimeType?.obs.value.toString()));  //  //  //     Stages.urlNewsImage =await ref.getDownloadURL().whenComplete(() => {  //     Stages.flagsNews.value =true  //     });  //     Stages.ListOFurlNewsImage.value.add(Stages.urlNewsImage);  //     Future.delayed(const Duration(microseconds: 500), () async {  //  //     });  //   } else {  //     Stages.flagsNews.value =false;  //  //     return "null";  //     // User canceled the picker  //   }  // }  // static upLodeImageSchedules({required text}) async {  //   Stages.urlSchedulesImage="";  //   Stages.flagsSchedules1.value =false;  //  //   final result = await FilePicker.platform.pickFiles(  //     type: FileType.image,  //   );  //  //  //  //   if (result != null) {  //     var mimeType = mime(result.files.single.name);  //  //  //  //     final file =await result.files.single.bytes;  //     Stages.bytesData1 = file;  //     var ref = FirebaseStorage.instance.ref("${text}Images").child("${DateTime.now().toString()+result.files.single.name}");  //     await ref.putData(file!,SettableMetadata(contentType: mimeType?.obs.value.toString()));  //  //  //     Stages.urlSchedulesImage =await ref.getDownloadURL().whenComplete(() => {  //       Stages.flagsSchedules1.value =true  //     });  //  //  //  //     Future.delayed(const Duration(microseconds: 500), () async {  //  //     });  //   } else {  //     Stages.flagsSchedules1.value =false;  //  //     return "null";  //     // User canceled the picker  //   }  // }  static void showAlerterror(BuildContext context ,String text) {    showDialog(      context: context,      builder: (BuildContext context) {        return AlertDialog(          title: Text(           textDirection: TextDirection.rtl,            'هناك خطأ',            style:Text_Style.getstyle(fontsize: 25, ColorText: Colorsapp.mainColor, fontWeight: FontWeight.w700),          ),          content: Text(            text,           textDirection: TextDirection.rtl,            style:Text_Style.getstyle(fontsize: 18, ColorText: Colorsapp.mainColor, fontWeight: FontWeight.w700),          ),          actions: <Widget>[            TextButton(              child: Text('OK'),              onPressed: () {                Navigator.of(context).pop();              },            ),          ],        );      },    );  }  static void showAlertDONE(BuildContext context ,String text) {    showDialog(      context: context,      builder: (BuildContext context) {        return AlertDialog(          title: Text(            textDirection: TextDirection.rtl,            'تم الارسال',            style:Text_Style.getstyle(fontsize: 25, ColorText: Colorsapp.mainColor, fontWeight: FontWeight.w700),          ),          content: Text(            text,            textDirection: TextDirection.rtl,            style:Text_Style.getstyle(fontsize: 18, ColorText: Colorsapp.mainColor, fontWeight: FontWeight.w700),          ),          actions: <Widget>[            TextButton(              child: Text('OK'),              onPressed: () {                Navigator.of(context).pop();              },            ),          ],        );      },    );  }}