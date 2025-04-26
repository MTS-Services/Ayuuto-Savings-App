import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 200,),
            Text("WelCome!" ,style:Theme.of(context).textTheme.bodyMedium),
            Text("Sign in to your Account" ,style:Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
