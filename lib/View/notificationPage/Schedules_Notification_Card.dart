import 'package:flutter/material.dart';import '../../help/Colors.dart';import '../../help/text_style.dart';class Schedules_Notification_Card extends StatelessWidget {  const Schedules_Notification_Card({    Key? key,    required this.data, required this.time, required this.author, required this.title, required this.stage, required this.color,  }) : super(key: key);  final Map<String, dynamic> data;  final String time;  final String author;  final String title;  final String stage;  final Color color;  @override  Widget build(BuildContext context) {    return Card(      color: color,      shape: RoundedRectangleBorder(        borderRadius: BorderRadius.circular(10.0),        side: BorderSide(color: Colorsapp.mainColor, width: 3.0),      ),      elevation: 5,      child: Container(        padding: const EdgeInsets.all(2),        child: Padding(          padding: const EdgeInsets.all(8),          child: Column(            mainAxisAlignment: MainAxisAlignment.spaceAround,            crossAxisAlignment: CrossAxisAlignment.end,            children: [              Text(                textDirection: TextDirection.rtl,                "تم ارسال جدول جديد بواسطة $author",                style: Text_Style.getstyle(                  fontWeight: FontWeight.bold,                  ColorText: Colors.black.withOpacity(0.7),                  fontsize:                  MediaQuery                      .of(context)                      .size                      .width / 20,                ),),              Text(                textDirection: TextDirection.rtl,                "$title",                style: Text_Style.getstyle(                  fontWeight: FontWeight.w400,                  ColorText: Colors.black.withOpacity(0.7),                  fontsize:                  MediaQuery                      .of(context)                      .size                      .width / 20,                ),),              Text(                textDirection: TextDirection.rtl,                "منذ $time",                style: Text_Style.getstyle(                  fontWeight: FontWeight.w500,                  ColorText: Colorsapp.redColor.withOpacity(0.7),                  fontsize:                  MediaQuery                      .of(context)                      .size                      .width / 25,                ),),            ],          ),        ),      ),    );  }}/**Column(            mainAxisAlignment: MainAxisAlignment.spaceAround,            crossAxisAlignment: CrossAxisAlignment.end,            children: [              Row(                mainAxisAlignment: MainAxisAlignment.spaceBetween,                children: [                  Text(                    textDirection: TextDirection.ltr,                    time,style: Text_Style.getstyle(                    fontWeight: FontWeight.w400,                    ColorText: Colorsapp.redColor.withOpacity(0.7),                    fontsize:                    MediaQuery                        .of(context)                        .size                        .width / 20,                  ),),                  Text(                    textDirection: TextDirection.rtl,                    author,style: Text_Style.getstyle(                    fontWeight: FontWeight.w600,                    ColorText: Colorsapp.redColor,                    fontsize:                    MediaQuery                        .of(context)                        .size                        .width / 20,                  ),),                ],              ),              Text("${title}",                textDirection: TextDirection.rtl,                style: Text_Style.getstyle(                  fontWeight: FontWeight.w600,                  ColorText: Colorsapp.mainColor,                  fontsize:                  MediaQuery                      .of(context)                      .size                      .width / 20,                ),),              Text(                textDirection: TextDirection.rtl,                stage,style: Text_Style.getstyle(                fontWeight: FontWeight.w600,                ColorText: Colorsapp.SecondColor,                fontsize:                MediaQuery                    .of(context)                    .size                    .width / 20,              ),),            ],          ),* */