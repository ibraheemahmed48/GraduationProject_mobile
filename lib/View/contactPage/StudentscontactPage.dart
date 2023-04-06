import 'dart:async';import 'dart:io';import 'package:flutter/material.dart';import 'package:flutter_svg/svg.dart';import 'package:get/get.dart';import 'package:loading_animation_widget/loading_animation_widget.dart';import 'package:notificationsystem_mobile/View/News_page/Divider.dart';import '../../controler/Alerts.dart';import '../../controler/method.dart';import '../../help/Colors.dart';import '../../help/text_style.dart';class ContactPage extends StatefulWidget {  @override  State<ContactPage> createState() => _ContactPageState();}class _ContactPageState extends State<ContactPage> {  final TextEditingController textController = TextEditingController();  final _formKey = GlobalKey<FormState>();  RxBool validatoremailflag = false.obs;  RxBool validatorpassflag = false.obs;  RxBool flags = false.obs;  @override  Widget build(BuildContext context) {    return Scaffold(      body: Stack(        children: [          Container(            padding: const EdgeInsets.all(0),            decoration: BoxDecoration(              gradient: LinearGradient(                colors: [Colorsapp.mainColor, Colorsapp.mainColor],                begin: Alignment.topCenter,                end: Alignment.bottomCenter,              ),            ),            child: SafeArea(              child: Column(                crossAxisAlignment: CrossAxisAlignment.center,                children: [                  Expanded(                    child: Container(                      decoration: const BoxDecoration(                        color: Colors.white,                        borderRadius: BorderRadius.only(                          topLeft: Radius.circular(0),                          topRight: Radius.circular(0),                        ),                      ),                      padding: const EdgeInsets.symmetric(horizontal: 20),                      child: SingleChildScrollView(                        child: Column(                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          crossAxisAlignment: CrossAxisAlignment.stretch,                          children: [                            const SizedBox(height: 10),                            Align(                              alignment: Alignment.centerRight,                              child: Row(                                mainAxisAlignment: MainAxisAlignment.spaceBetween,                                children: [                                  IconButton(onPressed: (){                                    Get.back();                                  },                                      icon:Icon(Icons.arrow_back_ios_new_sharp,                                        color: Colorsapp.mainColor,                                      )),                                  Text(                                    "تواصل مع الادارة",                                    style: Text_Style.getstyle(                                        fontsize:                                        MediaQuery.of(context).size.width / 15,                                        ColorText: Colorsapp.mainColor,                                        fontWeight: FontWeight.w700),                                  ),                                ],                              ),                            ),                            MyDivider1(width: MediaQuery.of(context).size.width/1.2,                                height: 2),                            const SizedBox(height: 30),                            Form(                              key: _formKey,                              child: Column(                                children: [                                  Directionality(                                      textDirection: TextDirection.rtl,                                      child: TextFormField(                                        minLines: 5,                                      maxLines: 5,                                      textAlign: TextAlign.start,                                      keyboardType:TextInputType.multiline,                                       textDirection: TextDirection.rtl,                                      controller: textController,                                      style: TextStyle(                                        color: Colorsapp.mainColor,                                        fontSize:                                        MediaQuery.of(context).size.width /                                            20,                                      ),                                      decoration: InputDecoration(                                        hintTextDirection: TextDirection.rtl,                                        errorStyle:Text_Style.getstyle(                                          ColorText: Colors.red,                                          fontsize: 14, fontWeight: FontWeight.w500,                                        ),                                        labelText: "النص",                                        labelStyle: Text_Style.getstyle(                                          ColorText: Colors.grey,                                          fontsize: 18, fontWeight: FontWeight.w500,                                        ),                                        enabledBorder: OutlineInputBorder(                                          borderRadius:                                          BorderRadius.circular(10),                                          borderSide: const BorderSide(                                            color: Colors.grey,                                          ),                                        ),                                        focusedBorder: OutlineInputBorder(                                          borderRadius:                                          BorderRadius.circular(10),                                          borderSide: BorderSide(                                            color: Colorsapp.SecondColor,                                          ),                                        ),                                        disabledBorder: OutlineInputBorder(                                          borderRadius:                                          BorderRadius.circular(10),                                          borderSide: BorderSide(                                            color: Colorsapp.redColor,                                          ),                                        ),                                        errorBorder: OutlineInputBorder(                                          borderRadius:                                          BorderRadius.circular(10),                                          borderSide: BorderSide(                                            color: Colorsapp.redColor,                                          ),                                        ),                                        filled: true,                                        fillColor: Colors.white,                                        contentPadding: const EdgeInsets.symmetric(                                          vertical: 15,                                          horizontal: 20,                                        ),                                      ),                                      validator: (value) {                                        if (value!.isEmpty) {                                          return 'النص فارغ';                                        }                                        return null;                                      })),                                ],                              ),                            ),                            const SizedBox(height: 10),                            const SizedBox(height: 30),                            Container(                                decoration: BoxDecoration(                                    borderRadius: BorderRadius.circular(20)                                ),                                child: ElevatedButton(                              onPressed: () async {                                flags.value =true;                                Future.delayed(const Duration(seconds: 2),(){                                  flags.value =false;                                });                                try {                                  final result = await InternetAddress.lookup('example.com');                                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {                                    print("////////////////_refreshData/////////////////////");                                    if (_formKey.currentState!.validate()) {                                      _formKey.currentState!.save();                                      await Methods.Student_text(                                          studentName: Methods.studentNmae,                                          text: textController.text,                                          stage:" المرحلة ${Methods.Stagesfield}");                                      if(Methods.studendtext.value==false){                                        Alerts.showAlertDONE(context, "تم الارسال بنجاح");                                        textController.text="";                                      }                                      if(Methods.studendtext.value==true){                                        Alerts.showAlerterror(context, "حدث خطأ");                                      }                                    }                                      ////////////////                                  }                                } on SocketException catch (_) {                                  print("////////////////No refreshData/////////////////////");                                  Alerts.showAlerterror(context, "لا يوجد انترنت");                                }                                // Perform login action                              },                              style: ElevatedButton.styleFrom(                                padding:                                const EdgeInsets.symmetric(vertical: 15),                                backgroundColor: Colorsapp.SecondColor,                                shape: RoundedRectangleBorder(                                  borderRadius: BorderRadius.circular(20),                                ),                              ),                              child: Text(                                'ارسال',                                style: Text_Style.getstyle(                                    fontsize: MediaQuery.of(context)                                        .size                                        .width /                                        20,                                    ColorText: Colorsapp.White,                                    fontWeight: FontWeight.w700),                              ),                            )),                            Obx(                                    () {                                  return flags.value==true?Center(                                    child: LoadingAnimationWidget.flickr(                                      size: 80,                                      leftDotColor: Colorsapp.mainColor,                                      rightDotColor: Colorsapp.SecondColor,                                      //color: Colorsapp.mainColor,                                    ),                                  ):const SizedBox(                                    width: 80,                                    height: 80,                                  );                                }                            ),                            SvgPicture.asset(                              'photo/Email campaign-rafiki.svg',                              width:MediaQuery.of(context).size.width/2,                              height: MediaQuery.of(context).size.height/4,                            )                          ],                        ),                      ),                    ),                  ),                ],              ),            ),          ),          Align(              alignment: Alignment.bottomCenter,              child: Padding(                padding: const EdgeInsets.all(8.0),                child: Text(                  "MTCE",                  style: Text_Style.getstyle(                      fontsize: MediaQuery.of(context).size.width / 12,                      ColorText: Colorsapp.mainColor,                      fontWeight: FontWeight.w700),                ),              )),        ],      ),    );  }}