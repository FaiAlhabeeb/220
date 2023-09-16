import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
              child: Text("Change  Password "),

            )
            ,  SizedBox(),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.password_rounded),
                hintText: 'Enter password',
                labelText: 'Old password ',
              ),

            )
            ,  SizedBox(),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.password_rounded),
                hintText: 'Enter password',
                labelText: 'new password ',
              ),

            ) , SizedBox(),

          ],
        ),



      ),
    );





  }

}