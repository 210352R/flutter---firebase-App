import 'package:flutter/material.dart';
import 'package:login_app/models/user.dart';
import 'package:login_app/screens/authenticate/authenticate.dart';
import 'package:login_app/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    FireBaseUser? user = Provider.of<FireBaseUser?>(context);
    print("By stream get Provider -- > $user");

    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }

    // return const Scaffold(
    //   body: Center(
    //     child: Authenticate(),
    //   ),
    // );
  }
}
