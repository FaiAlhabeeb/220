

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_exception_handler.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,

      child: Scaffold(

        appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xFFF3E5F5),
            title: const Text("Forgot Password",
              style: TextStyle(
              fontFamily:' Playfair Displa',
              color: Color(0xFF616161),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),),
            leading: IconButton(
              color: Color(0xFF616161),
              onPressed: () {

                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => Login() ),
                );
              },
              icon: const Icon(Icons.arrow_back),
            )
        ),


        body: Container(
        //  width: size.width,
         // height: size.height,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(20),


                child: Container(
              //    margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                  width: double.infinity,
                  height: 240,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("img/reset.jpeg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 20,)
             // const SizedBox(height: 70),

          //    const SizedBox(height: 15),
           ,   const Text(
                'Please enter your email address to reset your password.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Color(0xFF616161),
                  fontSize: 20,
                  fontFamily: 'Playfair Displa',
                  fontWeight: FontWeight.w700,


                ),
              ),
              const SizedBox(height: 40),

              Container(
                child: TextFormField(
                  obscureText: false,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Empty email';
                    }

                  },
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF616161)),
                  decoration: const InputDecoration(
                  //  contentPadding:
                   // EdgeInsets.symmetric(vertical: 10, horizontal: 5),

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF616161)),
                    borderRadius: BorderRadius.all(
                       Radius.circular(
                          10.0,
                        ),
                      ),
                    ),

                    isDense: true,
                    // fillColor: kPrimaryColor,
                    filled: true,
                    errorStyle: TextStyle(fontSize: 12),
                    hintText: 'email address',
                    hintStyle: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color:Color(0xFF616161) ),
                  ),
                ),
              ),


              const SizedBox(height: 1),

              //butoom








              const Expanded(child: SizedBox()),
              SizedBox(
                height: 200,
               // height: MediaQuery.of(context).size.height / 20,
                child: MaterialButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      final _status = await resetPassword(
                          email: _emailController.text.trim());
                      if (_status == AuthStatus.successful) {
                       
                        
                        //your logic
                      } else {


                      }
                    }
                  },
                  minWidth: double.infinity,
                  child: const Text(
                    'RECOVER PASSWORD',
                    style: TextStyle(
                      color: Color(0xFFD1C4E9),
                      fontSize: 18,
                      fontFamily: 'Playfair Displa',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

              ),
             // const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}