import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice_text_ai/widgets/BuildUI.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreen();
  }

}

class _HomeScreen extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice to Text AI",style: GoogleFonts.lato(),),
        centerTitle: true,
        //elevation: 2,
        //backgroundColor: Colors.white,
        //shadowColor: Colors.blue,

      ),
      body: BuildUI(),

    );
  }

}