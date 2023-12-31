import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hemmah/login.dart';
import 'package:hemmah/userchoice.dart';
TapGestureRecognizer tapGestureRecognizer = TapGestureRecognizer();

class SignupAsApplicants extends StatefulWidget {
  const SignupAsApplicants({super.key});

  @override
  State<SignupAsApplicants> createState() => _SignupAsApplicantsState();
}

class _SignupAsApplicantsState extends State<SignupAsApplicants> {
  
   final emailc = TextEditingController();
  bool isLoading = false;
  
   final fullname = TextEditingController();
   final passcc = TextEditingController();
  final passc = TextEditingController();
@override
  void dispose() {
    emailc.dispose();
    passc.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  Widget build(BuildContext context) {
    validate(){
      var yy=passc.text.contains(RegExp(  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')) ? null: "weak";
      var y= emailc.text.contains(RegExp( r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))? null: "Enter a valid email";print(y);
      if (emailc.text == "") {
        return "empty";
      } else if (y == "Enter a valid email") {
        return "incorrectEmailF";
      } else if (fullname.text == "") {
        return "empty";
      } else if (passc.text == "") {
        return "empty";
      } else if (passcc.text == "") {
        return "empty";
      }else if (yy == "weak"){return "weak";}
       else if (passcc.text != passc.text) {
        return "notMatch";
      }
       
       else {
        return "done";
      }
      
    } String s ="F";
    register() async{
      setState(() {
        isLoading = true;
      });
      try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailc.text,
    password: passc.text,
  );
  CollectionReference users =FirebaseFirestore.instance.collection('Applicants');

        users
            .doc(credential.user!.uid)
            .set(
              {
                'fullName': fullname.text,
                'Email': emailc.text,
                'password': passc.text,
              },
            )
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error")); s = "D";
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    final snackBar = SnackBar(
            content: const Text('The password provided is too weak.'),
            action: SnackBarAction(
              label: 'close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
     ScaffoldMessenger.of(context).showSnackBar(snackBar); s = "w";
    
  } else if (e.code == 'email-already-in-use') {
     final snackBar = SnackBar(
            content: const Text('The account already exists for that email.'),
            action: SnackBarAction(
              label: 'close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    s = "exist";
  }
} catch (e) {
  print(e);
}
 setState(() {
        isLoading = false;
      });
    }
     return SafeArea(
      child: Scaffold(
  appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFF3E5F5),
            title: Text(
              "Sign Up As Applicant",
              style: TextStyle(
                fontFamily: ' Playfair Displa',
                color: Color(0xFF616161),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => userchoice()),
                );
              },
              icon: Icon(Icons.arrow_back),
              color: Color(0xFF616161),
            )),

        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                 
        SizedBox(height: 5,),
        TextFormField(
                        // we return "null" when something is valid
                       validator: (value) {
                            return !value.toString().isEmpty
                                ? null
                                : "Empty";
                          },
                          controller: fullname,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        decoration:const InputDecoration(
                          
                            hintText: "Enter your full name : ",
                            suffixIcon: Icon(Icons.person_2_outlined))),
                  SizedBox(height: 10,),
                  TextFormField(
                        // we return "null" when something is valid
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "Enter a valid email";
                        },
                        
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: emailc,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration:const InputDecoration(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.email_outlined))),
                            SizedBox(height: 10,),
                            TextFormField(
                        // we return "null" when something is valid
                        validator: (passc) {
                          return passc!.contains(RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))
                              ? null
                              : "Enter a valid password (should contain at least one upper case \n,at least one lower case , at least one digit ,\n at least one Special character , at least 8 characters in length )";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        
                        controller: passc,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration:const InputDecoration(
                            hintText: "Enter Your password : ",
                            suffixIcon: Icon(Icons.visibility))),
                            SizedBox(height: 10,),
                            TextFormField(
                        // we return "null" when something is valid
                        validator: (value) {
                          return passc.text.compareTo(value.toString())==0
                              ? null 
                              : "Different password";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passcc,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration:const InputDecoration(
                            hintText: "Confirm Your password : ",
                            suffixIcon: Icon(Icons.visibility))),
                        SizedBox(height: 20,),
       ElevatedButton (
                      onPressed: () async {
                        String x = validate(); print(x);
                    if (validate() == "done") {
                      await register();
                      if (!mounted) return;
                      if(s=="D"){final snackBar = SnackBar(
                        content: const Text(
                            'Successfully Register'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Login()));}
                      
                      
                    }
                    else if (s=="exist"){
                      final snackBar = SnackBar(
                        content: const Text(
                            'The account already exists for that email.'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }
                    else if (validate() == "weak" || s =="w"){
                      final snackBar = SnackBar(
                        content: const Text(
                            'the password is weak , A password must contains at least eight characters, including at least one number and includes both lower and uppercase letters and special characters'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                    else if (validate() == "incorrectEmailF"){
                      final snackBar = SnackBar(
                        content: const Text(
                            'email address format is not correct'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                     else if (validate() == "empty"){final snackBar = SnackBar(
                        content: const Text(
                            'some of the field is empty'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                    else if (validate() == "notMatch"){final snackBar = SnackBar(
                        content: const Text(
                            'Password is not identical '),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                     else {
                      final snackBar = SnackBar(
                        content: const Text(
                            'Erorr'),
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);}
                        
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(
                                
                               fontSize: 19,  
 color:Color(0xFFF5F5F5),
                                ),
                            ),
                      style: ButtonStyle(
                       backgroundColor:
                        MaterialStateProperty.all(Color(0xFFD1C4E9)),
                    padding: MaterialStateProperty.all(EdgeInsets.only(left:23,right: 23)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    SizedBox(height: 20,),
      Container(
          width: 350,
          height: 30,
          margin: EdgeInsets.fromLTRB(50, 20, 0, 0),
          child: Row(
              children: [
                Text(
                   'Already have an account ? ',
                  style: TextStyle(
                    color: Color(0xFF616161),
                          fontSize: 18,
                          fontFamily: 'Playfair Displa',
fontWeight: FontWeight.w700,
                  ),
                ),

                InkWell(child:Text(
                  
                   'Sign in',
                  style: TextStyle(
                     fontSize: 15,
                            color: Color.fromARGB(151, 97, 97, 97),
                    
                  ),
                   ),
                onTap: () { Navigator.pushNamed(context, '/login');},)

              ]
            )
        ),
      





                ],



              )



            ),
          ),
        ),
      ),
    );
  }
}