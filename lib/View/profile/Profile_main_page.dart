import 'dart:io';import 'package:cloud_firestore/cloud_firestore.dart';import 'package:firebase_auth/firebase_auth.dart';import 'package:firebase_storage/firebase_storage.dart';import 'package:flutter/material.dart';import 'package:get/get.dart';import 'package:get/get_core/src/get_main.dart';import 'package:image_picker/image_picker.dart';import 'package:notificationsystem_mobile/View/Login_page/login_main_page.dart';import 'package:path/path.dart' as Path;import '../../controler/method.dart';import '../../help/Colors.dart';import '../../help/text_style.dart';import '../News_page/Divider.dart';import 'Button_Profile.dart'; class Profile_main_page extends StatefulWidget {   const Profile_main_page({Key? key}) : super(key: key);   @override   State<Profile_main_page> createState() => _Profile_main_pageState(); } class _Profile_main_pageState extends State<Profile_main_page> {   String? _userName;   String? _userEmail;   String? _userImageUrl;   File? _imageFile;   @override   void initState() {     super.initState();     _getUserInfo();   }   void _getUserInfo() async {     User? user = FirebaseAuth.instance.currentUser;     setState(() {       _userName = user?.displayName;       _userEmail = user?.email;       _userImageUrl = user?.photoURL;     });   }   void _signOut() async {     await FirebaseAuth.instance.signOut();     Get.offAll(LogIn_Main_Page());   }   void _resetPassword() async {     String? email = FirebaseAuth.instance.currentUser?.email;     await FirebaseAuth.instance.sendPasswordResetEmail(email: email!);     showDialog(       context: context,       builder: (_) => AlertDialog(         title: const Text('Password Reset Link Sent'),         content: const Text('Please check your email to reset your password.'),         actions: [           TextButton(             onPressed: () {               Navigator.pop(context);             },             child: const Text('OK'),           ),         ],       ),     );   }    _pickImage() async {     final pickedFile =     await ImagePicker().getImage(source: ImageSource.gallery);     setState(() {       _imageFile = File(pickedFile!.path);     });   }   Future<String?> uploadImage1(File imageFile) async {     try {       // Create a reference to the location where you want to store the file in Cloud Storage.       Reference storageReference = FirebaseStorage.instance.ref().child('user_profile_images/${DateTime.now().millisecondsSinceEpoch}${imageFile.path}');       // Upload the file to Cloud Storage.       await storageReference.putFile(imageFile);       // Get the download URL of the uploaded file.       String imageUrl = await storageReference.getDownloadURL();          print("imageUrl: ${imageUrl}");       // Return the download URL.       return imageUrl;     } catch (e) {       print(e);       return null;     }   }    _updateProfile() async {     if (_imageFile != null) {       String? imageUrl = await uploadImage1(_imageFile!);       User? user = FirebaseAuth.instance.currentUser;       await user?.updatePhotoURL(imageUrl);       setState(() {         _userImageUrl = imageUrl;       });     }   }   Future addImageUrlToDocument({required String documentId, required String imageUrl}) async {     try {       // Create a reference to the document you want to update.       DocumentReference documentReference = FirebaseFirestore.instance.collection('Student').doc(documentId);       // Update the document with the download URL.       await documentReference.update({         'imageUrl': imageUrl,       });       // Display a success message.       print('Download URL added to document with ID: $documentId');     } catch (e) {       print('Error adding download URL to document: $e');     }   }   @override   Widget build(BuildContext context) {     return Padding(       padding: const EdgeInsets.all(8.0),       child: Center(         child: Column(           mainAxisAlignment: MainAxisAlignment.start,           children: [             _userImageUrl==null?             Padding(               padding: const EdgeInsets.all(8.0),               child: Center(child: Icon(Icons.person,size: MediaQuery.of(context).size.width/3,)),             ):     Padding(       padding: const EdgeInsets.all(8.0),       child: CircleAvatar(         radius: MediaQuery.of(context).size.width/5,       backgroundColor: Colorsapp.mainColor,       backgroundImage:        NetworkImage(_userImageUrl!,        )       ),     ),             Text(               "${Methods.studentNmae}",               style: Text_Style.getstyle(                   fontsize: MediaQuery.of(context).size.width / 20,                   ColorText: Colorsapp.mainColor,                   fontWeight: FontWeight.w700),             ),             Text(               " المرحلة ${Methods.Stagesfield}",               textDirection: TextDirection.rtl,               style: Text_Style.getstyle(                   fontsize: MediaQuery.of(context).size.width / 20,                   ColorText: Colorsapp.mainColor,                   fontWeight: FontWeight.w500),             ),             SelectableText(               "${_userEmail}",               style: Text_Style.getstyle(                   fontsize: MediaQuery.of(context).size.width / 20,                   ColorText: Colorsapp.mainColor,                   fontWeight: FontWeight.w500),             ),             Padding(               padding: const EdgeInsets.all(8.0),               child: MyDivider1(width: MediaQuery.of(context).size.width, height: 2),             ),              Button_Profile(title: 'تحديث الصورة',                onPressed: () async {                  await _pickImage();                  await uploadImage1(_imageFile!);                  await _updateProfile();                  await addImageUrlToDocument(documentId: '${Methods.DocumentReference1}', imageUrl:_userImageUrl! );                },),             Button_Profile(title: 'نسجيل خروج',               onPressed:_signOut,),             Button_Profile(title: 'تحديث الصورة',               onPressed: () async {                 await _pickImage();                 await uploadImage1(_imageFile!);                 await _updateProfile();                 await addImageUrlToDocument(documentId: '${Methods.DocumentReference1}', imageUrl:_userImageUrl! );               },),             Align(               child: Text(                 "MTCE",                 style: Text_Style.getstyle(                     fontsize: MediaQuery.of(context).size.width / 20,                     ColorText: Colorsapp.mainColor,                     fontWeight: FontWeight.w700),               ),             ),           ],         ),       ),     );   } }