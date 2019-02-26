import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

//for stateful widget we need to define create state method and a sepersate class that represents the actual state of th class
class LoginScreen extends StatefulWidget {  
  createState() {
    return LoginScreenState();  
  } 
}
                                                  //also use methods from the validationmixin class                                    
class LoginScreenState extends State<LoginScreen> with ValidationMixin{
  final formKey = GlobalKey<FormState>();           //for storing values of form //video 12.13 and 12.14

  String email= '';
  String password= '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(                  //column is for the layout
          children: [                   //mention children when more than one elements is being added to the container
            Container(margin: EdgeInsets.only(top: 50.0)),
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(top: 25.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,                //adding the @ symbol to the keyboard. easier entry for users
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
      validator:  validateEmail,          //no () since this is just a reference to the function and not actually calling the funstion
      onSaved: (String value){
        email= value;
      },
    );
  }

  Widget passwordField(){
    return TextFormField(
        obscureText: true,             //for getting the ** while entering password      
        decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      validator: validatePassword,
      onSaved:  (String value){
        password=value;
      },
    );
  }

  Widget submitButton(){
    return RaisedButton(
      color: Colors.blue,
      child: Text('Submit!'),
      onPressed: (){
        if(formKey.currentState.validate()){          //validate() functions= calls the validatr function in all the form components. video 12.17-12.19.
          formKey.currentState.save();                //calls the onsaved functions.
          print('Time to post $email and $password to API');
        }
      },
    );
  }
}