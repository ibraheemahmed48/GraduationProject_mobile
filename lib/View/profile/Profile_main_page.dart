import 'dart:io';import 'package:cached_network_image/cached_network_image.dart';import 'package:cloud_firestore/cloud_firestore.dart';import 'package:firebase_auth/firebase_auth.dart';import 'package:firebase_storage/firebase_storage.dart';import 'package:flutter/material.dart';import 'package:flutter_svg/svg.dart';import 'package:get/get.dart';import 'package:image_picker/image_picker.dart';import 'package:loading_animation_widget/loading_animation_widget.dart';import 'package:notificationsystem_mobile/View/Login_page/login_main_page.dart';import 'package:notificationsystem_mobile/controler/auth/Account.dart';import '../../controler/auth/auth.dart';import '../../controler/method.dart';import '../../help/Colors.dart';import '../../help/text_style.dart';import '../News_page/Divider.dart';import '../contactPage/StudentscontactPage.dart';import 'Button_Profile.dart'; class Profile_main_page extends StatefulWidget {   const Profile_main_page({Key? key}) : super(key: key);   @override   State<Profile_main_page> createState() => _Profile_main_pageState(); } class _Profile_main_pageState extends State<Profile_main_page> {   File? _imageFile;   RxBool awaitImage =false.obs;   RxBool signOutflag =false.obs;   @override   int width =20;   void initState() {     print("Account.email.length : ${Account.email.length}");     if(Account.email.length<30){       width = 20;     }else if(Account.email.length>30){       width = 25;     }     super.initState();     UserPreferences.getAccount1();       print("Account.documentID : ${Account.documentID}");   }   void signOut() async {     signOutflag.value=true;     // FirebaseMessaging.instance.unsubscribeFromTopic("First");     // FirebaseMessaging.instance.unsubscribeFromTopic("Second");     // FirebaseMessaging.instance.unsubscribeFromTopic("Third");     // FirebaseMessaging.instance.unsubscribeFromTopic("Fourth");     await Methods.deleteToken(documentId: Account.documentID);     print("1");     await UserPreferences.clearCredentials();     print("3");     print("4");     await FirebaseAuth.instance.signOut();     print("2");     await Future.delayed(Duration(seconds: 2),(){       signOutflag.value=false;     });     // FirebaseFirestore firestore = FirebaseFirestore.instance;     // await firestore.clearPersistence();     await Get.offAll(LogIn_Main_Page(),transition: Transition.fadeIn,duration: const Duration(seconds: 2));try{     DocumentReference documentReference = FirebaseFirestore.instance.collection('Student').doc(Methods.DocumentReference1);     // Update the document with the download URL.     await documentReference.update({       'Token': "",     });     // Display a success message.     print('Download Token added to document with ID: ${Methods.DocumentReference1}');   } catch (e) {   print('Error adding download URL to document: $e');   }   }////////////////////////////////////////////////////////////////////////////////////////   final _picker = ImagePicker();   Future<String?> uploadImageToFirebase() async {     final pickedFile = await _picker.getImage(source: ImageSource.gallery);     if (pickedFile != null) {       awaitImage.value=true;       File file = File(pickedFile.path);       FirebaseStorage storage = FirebaseStorage.instance;       Reference storageRef = storage.ref().child('profile_images/${DateTime.now().toString()}');       UploadTask uploadTask = storageRef.putFile(file);       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);       String imageUrl = await taskSnapshot.ref.getDownloadURL();       return imageUrl;     } else {       return null;     }   }   Future<void> updateProfileImage(String newImageUrl) async {     User? user = FirebaseAuth.instance.currentUser;     if (user != null) {       awaitImage.value=true;       await user.updatePhotoURL(newImageUrl);     }   }   Future<void> deleteProfileImage() async {     User? user = FirebaseAuth.instance.currentUser;     if (user != null) {       await user.updatePhotoURL(null);     }   }   Future addImageUrlToDocument({required String documentId, required String imageUrl}) async {     print("documentId : $documentId");     print("imageUrl : $imageUrl");     try {       // Create a reference to the document you want to update.       DocumentReference documentReference = FirebaseFirestore.instance.collection('Student').doc(documentId);       // Update the document with the download URL.       await documentReference.update({         'imageUrl': imageUrl,       });       // Display a success message.       print('Download URL added to document with ID: $documentId');     } catch (e) {       print('Error adding download URL to document: $e');     }   }   @override   Widget build(BuildContext context) {     return Padding(       padding: const EdgeInsets.all(8.0),       child: Center(         child: Column(           mainAxisAlignment: MainAxisAlignment.spaceBetween,           children: [                Column(                  children: [                    Obx(                       () {                        return awaitImage.value==false? Column(                          children: [                           Padding(                              padding: const EdgeInsets.all(8.0),                              child: Container(                                  decoration: BoxDecoration(                                      border: Border.all(                                        color: Colorsapp.White,                                        width: 4,                                      ),                                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/5)                                  ),                                  child:  Container(                                      height: MediaQuery.of(context).size.height/5,                                      width: MediaQuery.of(context).size.height/5,                                      decoration:  BoxDecoration(                                        shape: BoxShape.circle,                                        color:  Colors.blueGrey.withOpacity(0.3),                                      ),                                      child: CircleAvatar(                                        backgroundColor: Colorsapp.mainColor.withOpacity(0.3),                                        backgroundImage: FirebaseAuth.instance.currentUser?.photoURL == null ? null :                                        CachedNetworkImageProvider(FirebaseAuth.instance.currentUser!.photoURL!,                                        ),                                        child: FirebaseAuth.instance.currentUser?.photoURL == null                                            ? const Icon(                                          Icons.person,                                          size: 40,                                          color: Colors.white,                                        )                                            :null                                      )                                  )),                            )                          ],                        ):Padding(                          padding: const EdgeInsets.all(8),                          child: Container(                            decoration:  BoxDecoration(                              shape: BoxShape.circle,                              color: Colorsapp.mainColor.withOpacity(0.3),                            ),                            height: MediaQuery.of(context).size.height/5,                            width: MediaQuery.of(context).size.height/5,                            child: Center(                              child: LoadingAnimationWidget.twoRotatingArc(                                size: 50,                               // leftDotColor: Colorsapp.mainColor,                                //rightDotColor: Colorsapp.SecondColor,                               color: Colorsapp.mainColor,                              ),                            ),                          ),                        );                      }                    ),                   Text(                      Account.name,                      style: Text_Style.getstyle(                          fontsize: MediaQuery.of(context).size.width / 20,                          ColorText: Colorsapp.mainColor,                          fontWeight: FontWeight.w700),                    ),                    Text(                      " المرحلة ${Account.stage}",                      textDirection: TextDirection.rtl,                      style: Text_Style.getstyle(                          fontsize: MediaQuery.of(context).size.width / 20,                          ColorText: Colorsapp.mainColor,                          fontWeight: FontWeight.w500),                    ),                    SelectableText(                      Account.email,                      style: Text_Style.getstyle(                          fontsize: MediaQuery.of(context).size.width / width,                          ColorText: Colorsapp.mainColor,                          fontWeight: FontWeight.w500),                    ),                    MyDivider1(width: MediaQuery.of(context).size.width, height:2),                  ],                ),            Container(              width: MediaQuery.of(context).size.width/1.1,              decoration: BoxDecoration(                color: Colorsapp.White,                 borderRadius: BorderRadius.circular(10)              ),              child: Column(                children: [                 profileButton2(onPressed: () async {                   ///////////////////////////////////////                   String? newImageUrl = await uploadImageToFirebase();                   if (newImageUrl != null) {                     await updateProfileImage(newImageUrl);                     await addImageUrlToDocument(documentId: '${Account.documentID}', imageUrl:newImageUrl );                     awaitImage.value=false;                   }                 }, text: 'تحديث الصورة',                   icon: Icon(Icons.photo_camera_front_outlined,                     color: Colorsapp.mainColor,                   ),),                  profileButton2(onPressed: () async {                    Get.to(ContactPage(),transition: Transition.fadeIn,duration: const Duration(seconds: 1));                  }, text: 'تواصل',                    icon: Icon(Icons.comment_rounded,                      color: Colorsapp.mainColor,                    ),),                  profileButton2(onPressed: () async {                    await Methods.resetPassword(context, Account.email);                    Future.delayed(Duration(seconds: 2),(){                      signOut();                    });                  }, text: 'إعادة تعيين كلمة المرور',                    icon: Icon(Icons.password,                      color: Colorsapp.mainColor,                    ),),                ],              ),            ),            SvgPicture.asset("photo/Nerd-amico.svg",              width:MediaQuery.of(context).size.width / 1.2,              height:MediaQuery.of(context).size.height /5,            ),            Obx(              () {                return SizedBox(                  width:MediaQuery.of(context).size.width/2,                  height: MediaQuery.of(context).size.height/13,                  child: signOutflag.value==false ?TextButton(onPressed: (){                    signOut();                  },child: Text(                    "تسجيل خروج",                    style: Text_Style.getstyle(                        fontsize: MediaQuery.of(context).size.width / 20,                        ColorText: Colorsapp.redColor,                        fontWeight: FontWeight.w700),                  ),                  ):Center(                    child: LoadingAnimationWidget.flickr(                      size: 80,                      leftDotColor: Colorsapp.mainColor,                      rightDotColor: Colorsapp.SecondColor,                      //color: Colorsapp.mainColor,                    ),                  )                );              }            )           ],         ),       ),     );   } }