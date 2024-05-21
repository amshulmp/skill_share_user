import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skill_share_user/config/styles.dart';
import 'package:skill_share_user/firebase/functions.dart';
import 'package:skill_share_user/widgets/button.dart';
import 'package:skill_share_user/widgets/textbox.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    TextEditingController emailcotroller = TextEditingController();
  void _showSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
   bool _validateEmail() {
    return emailcotroller.text.trim().isNotEmpty;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("change password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "enter your email we will send a mail to the given email you can change the password by clicking email link ",
              style: Styles.subtitlegrey(context),
            ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Textbox(
                  hideText: false,
                  tcontroller: emailcotroller,
                  type: TextInputType.emailAddress,
                  hinttext: 'Email',
                  icon: Icon(Icons.email,color:Theme.of(context). colorScheme.onPrimary,),
                ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                CustomLoginButton(text: "Send email", onPress: ()async{
                if (_validateEmail()) {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcotroller.text.trim());
                    _showSnackbar("Password reset email sent successfully!");
                    Navigator.pop(context);
                  } catch (e) {
                    _showSnackbar("Error: $e");
                  }
                } else {
                  _showSnackbar("Please enter an email address.");
                }
              

                })
          ],
        ),
      ),
    );
  }
}
