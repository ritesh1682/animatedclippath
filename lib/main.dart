import 'package:flutter/material.dart';
import 'dart:math' as math;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {


  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  void initState() {
    super.initState();
    _controller = AnimationController(value:0.0,duration: Duration(seconds: 25), upperBound: 1,lowerBound: -1,vsync: this)..repeat();
  }
  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;


    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
               AnimatedBuilder(animation: _controller,
          child:     Container(
            height: size.height * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF000428),
                    Color(0xFF004e92)
                  ]
              ),
            ),
          ),
          builder:(context, child) {
                    return ClipPath(
                      clipper: DrawClip(_controller.value),
                      child: child
                  );
                }
              ),

               Container(
                  padding: EdgeInsets.only(bottom: 60),
                  child:Text(
                    'Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              Text('Clipper Path',style: TextStyle(
                color: Colors.white
              ),),
            ],
          ),
          Text(
            'Sign Up To Continue',
            style: TextStyle(
              color:  Color(0xFF000428),
              fontSize: 16,
            ),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 18),
            child: input('Username'),
          ),
          Container(
            width: size.width * 0.8,
            margin: EdgeInsets.only(top: 18),
            child: input('Password',isPass: true),
          ),
          Container(
            margin: EdgeInsets.only(top: 38),
            child: GestureDetector(
              onTap: () {},
              child: Text('I dont remember password ',style: TextStyle(
                color:  Color(0xFF000428),
              ),),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Expanded(child: Center(
                    child: GestureDetector(

                      onTap: () {},
                      child: Text('You dont have the account?',
                      style: TextStyle(
                        color: Color(0xFF004e92),
                        fontSize: 14,
                      ),
                      ),
                    ),
                  ),),
                  Expanded(child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text('Register',
                      style: TextStyle(
                        color:  Color(0xFF000428),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),

                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget input (String hint , {bool isPass = false}) {
  return TextField(
    obscureText: isPass,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Color(0xFF004e92),fontSize: 14
      ),
      contentPadding: EdgeInsets.only(top: 20,bottom: 20,left: 38),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFC7C7C7)),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF000428),),
        borderRadius: BorderRadius.all(Radius.circular(15.0),),
    )
    ),
  );
}

class DrawClip extends CustomClipper<Path>{

  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);


  @override
  Path getClip(Size size) {

    Path path = Path();
    path.lineTo(0, size.height*0.8);
    double xCenter = size.width *0.5 + (size.width *0.6 + 1) *math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);

    path.quadraticBezierTo(xCenter, yCenter,size.width,size.height*0.8);
    path.lineTo(size.width,0);


    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
      return true;
  }

}