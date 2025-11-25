import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Image(image: AssetImage('assets/oldage.jpg'), fit: BoxFit.cover)),  
            Padding(
              padding: const EdgeInsets.only(left: 50,top:200),
              child: Text("Aerofit",style: GoogleFonts.poppins(fontSize: 30,color: Colors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(left:50,right: 50,top: 270),
              child: Text("The golden hour, that fleeting period of time just after sunrise or before sunset, casts a magical and transformative glow upon the world. During these moments, the sun hangs low in the sky, its light diffused and warm, painting everything in shades of amber, gold, and soft orange. It's a time when ordinary landscapes become extraordinary, shadows stretch into long, dramatic shapes, and even the most mundane objects are imbued with a sense of wonder and tranquility. Photographers and artists eagerly anticipate this brief window, knowing that it offers the perfect conditions to capture breathtaking images and create art that speaks to the heart.",style: GoogleFonts.poppins(),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 800,left: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width/1.2,
                height: MediaQuery.of(context).size.height/13,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  onPressed: (){
                    Get.toNamed('/login');
                  }, child: Text("Get Started",style: GoogleFonts.poppins(fontSize: 20,color: Colors.black),)),
              ),
            )
          ],
        ),
      ) 
    );  
  } 
} 