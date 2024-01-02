import 'package:flutter/material.dart';
import 'package:login_app/services/auth.dart';
import 'package:login_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Brew Crew'),
              actions: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      child: Text(
                        'Sign In ! ',
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          print("call sign in with email and password");
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            print(
                                "******------ There is an error in sign in -------******");
                            setState(() {
                              loading = false;
                              error =
                                  'Could not sign in with those credentials';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 50.0),
                      child: ElevatedButton(
                        child: const Text('sign in anon'),
                        onPressed: () async {
                          dynamic result = await _auth.signInAnon();
                          if (result == null) {
                            print('error with signing in  ============= ');
                            setState(() => loading = false);
                          } else {
                            setState(() => loading = true);
                            print('signed in Annonimously =============');
                            print(result);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}



// body: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//         child: ElevatedButton(
//           child: const Text('sign in anon'),
//           onPressed: () async {
//             dynamic result = await _auth.signInAnon();
//             if (result == null) {
//               print('error with signing in  ============= ');
//             } else {
//               print('signed in Annonimously =============');
//               print(result);
//             }
//           },
//         ),
//       ),