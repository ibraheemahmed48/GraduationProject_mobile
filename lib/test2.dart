// import 'package:flutter/material.dart';// import 'package:flutter/services.dart';// import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';//// import 'help/Colors.dart';////// class SnakeNavigationBarExampleScreen extends StatefulWidget {//   const SnakeNavigationBarExampleScreen({Key? key}) : super(key: key);////   @override//   _SnakeNavigationBarExampleScreenState createState() =>//       _SnakeNavigationBarExampleScreenState();// }//// class _SnakeNavigationBarExampleScreenState//     extends State<SnakeNavigationBarExampleScreen> {////   ShapeBorder? bottomBarShape = const RoundedRectangleBorder(//     borderRadius: BorderRadius.only(//       topRight: Radius.circular(25),//       topLeft:Radius.circular(25), ),//   );//   SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;////   int _selectedItemPosition = 0;//   SnakeShape snakeShape = SnakeShape.circle;////   bool showSelectedLabels = true;//   bool showUnselectedLabels = false;////   Color selectedColor = Colorsapp.mainColor;//   Color unselectedColor = Colors.blueGrey;//////   Color? containerColor;////   static List<Widget> _widgetOptions = <Widget>[//     Text("s"),//     Text("f"),//     Text("s"),//     Text("f"),//     Text("s"),//     Text("f"),//   ];//   @override//   Widget build(BuildContext context) {//     return Scaffold(//       body: SafeArea(child: _widgetOptions[_selectedItemPosition],),////////       bottomNavigationBar: SnakeNavigationBar.color(//          height: 55,//         elevation: 50,//         behaviour: snakeBarStyle,//         snakeShape: snakeShape,//         shape: bottomBarShape,//         padding: EdgeInsets.zero,////         ///configuration for SnakeNavigationBar.color//         snakeViewColor: selectedColor,//         selectedItemColor://         snakeShape == SnakeShape.indicator ? selectedColor : null,//         unselectedItemColor: unselectedColor,////         ///configuration for SnakeNavigationBar.gradient//         // snakeViewGradient: selectedGradient,//         // selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,//         // unselectedItemGradient: unselectedGradient,////         showUnselectedLabels: showUnselectedLabels,//         showSelectedLabels: showSelectedLabels,////         currentIndex: _selectedItemPosition,//         onTap: (index) => setState(() => _selectedItemPosition = index),//         items: const [//           BottomNavigationBarItem(////               icon: Icon(Icons.notifications), label: 'tickets'),//           BottomNavigationBarItem(//               icon: Icon(Icons.ice_skating_sharp), label: 'calendar'),////           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),////           BottomNavigationBarItem(//               icon: Icon(Icons.account_circle), label: 'microphone'),//////         ],//         selectedLabelStyle: const TextStyle(fontSize: 14),//         unselectedLabelStyle: const TextStyle(fontSize: 10),//       ),//     );//   }////// }//