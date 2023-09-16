import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hemmah/GetDatafromApplicant.dart';
import '';
import 'applicantProfile.dart';
class homepageapplicant extends StatefulWidget {
   homepageapplicant({super.key});

  @override
  State<homepageapplicant> createState() => _homepageapplicantState();
}

class _homepageapplicantState extends State<homepageapplicant> {
  final credintial = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF3E5F5),
        actions: [
          IconButton(onPressed:() {
            
          }, icon: Icon(Icons.search
          ,color: Color(0xFF616161),
          )),
        ],

        title: Text(
              "Home",
              style: TextStyle(
                fontFamily: ' Playfair Displa',
                color: Color(0xFF616161),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
     
      extendBodyBehindAppBar: true,
      bottomNavigationBar: GNav(
        color: Color.fromARGB(255, 251, 246, 246),
        backgroundColor: Color.fromARGB(255, 231, 227, 227),
        activeColor: Color.fromARGB(255, 164, 112, 168),
        selectedIndex: 0,
        tabs: [
      
        GButton(icon: Icons.ad_units_outlined , iconColor:Color.fromARGB(255, 135, 108, 139) ,onPressed: (){ }, ),
        GButton(icon: Icons.add_alert_outlined, iconColor: Color.fromARGB(255, 135, 108, 139), ),
        GButton(icon: Icons.add_box_outlined , iconColor: Color.fromARGB(255, 135, 108, 139),),
        GButton(icon: Icons.account_box , iconColor:Color.fromARGB(255, 135, 108, 139) ,onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=> const applicantProfile()));
        },),

       // ontapechange: (index) { home i 0 azed ala a5r wa7d}

      ]),
      
     
      
      body: SingleChildScrollView (child: Column(
        children: [
           
          
           
                    
                 
                     
                     
            
                 
                ],
          
          
              ),
          
          
                
              ),
          
       
     
      
      );
  }
}