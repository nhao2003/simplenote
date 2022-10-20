import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login-screen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = true;
  double password_strength = 0;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode authMode = AuthMode.Login;

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    void save() {
      if (!_formKey.currentState!.validate()) return;
      _formKey.currentState!.save();
    }
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black12,
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(30, 15, 15, 55),
                  child: const FlutterLogo(),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 15, 15, 55),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Bonjour!\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Welcome to ',
                        ),
                        TextSpan(
                          text: 'Simple ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            fontSize: 30,
                          ),
                        ),
                        TextSpan(
                          text: 'Note❤️',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purpleAccent,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 15, 15, 55),
                  height: 400,
                  child: ListView(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          //hintText: 'Email',
                          labelText: 'Email',
                        ),
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          if (!value!.contains('@')) return "Invalid email";
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: _showPassword
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        obscureText: _showPassword,
                        validator: (String? value) {
                          if (authMode == AuthMode.Signup) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else {
                              //call function to check password
                              bool result = validatePassword(value);
                              if (result) {
                                // create account event
                                return null;
                              } else {
                                return " Password should contain Capital,\n small letter & Number & Special";
                              }
                            }
                          }
                        },
                        onSaved: (value) {},
                      ),
                      if (authMode == AuthMode.Signup)
                        TextFormField(
                          enabled: authMode == AuthMode.Signup,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: _showPassword
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off),
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          obscureText: _showPassword,
                          validator: authMode == AuthMode.Signup
                              ? (value) {
                            if (value != passwordController.text) {
                              return 'Passwords do not match!';
                            }
                          }
                              : null,
                          onSaved: (value) {},
                        ),
                      if (authMode == AuthMode.Signup)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: LinearProgressIndicator(
                            value: password_strength,
                            backgroundColor: Colors.grey[300],
                            minHeight: 5,
                            color: password_strength <= 1 / 4
                                ? Colors.red
                                : password_strength == 2 / 4
                                    ? Colors.yellow
                                    : password_strength == 3 / 4
                                        ? Colors.blue
                                        : Colors.green,
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: Column(children: [
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: save,
                              child: Text((authMode == AuthMode.Login)
                                  ? "Login in"
                                  : "Sign up"),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot password",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (authMode == AuthMode.Signup)
                                      authMode = AuthMode.Login;
                                    else
                                      authMode = AuthMode.Signup;
                                  });
                                },
                                child: Text(
                                  (authMode == AuthMode.Login)
                                      ? "Create an account"
                                      : "Login",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ]),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
