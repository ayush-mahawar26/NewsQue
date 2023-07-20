import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constant/size.config.dart';
import 'package:news_app/services/firebase.auth.services.dart';
import 'package:news_app/views/auth_views/create.acc.view.dart';

class LoginAuthView extends StatefulWidget {
  LoginAuthView({super.key});

  @override
  State<LoginAuthView> createState() => _LoginAuthViewState();
}

class _LoginAuthViewState extends State<LoginAuthView> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();

  bool ishidden = true;

  void toggle() {
    setState(() {
      ishidden = !ishidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/newsicon.png",
              height: SizeConfig.height / 5,
            ),
            Text(
              "Login",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 40, fontWeight: FontWeight.w700),
            ),
            Text(
              "Welcome Back Readers !",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                controller: _email,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                controller: _pass,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 18),
                keyboardType: TextInputType.emailAddress,
                obscureText: ishidden,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        toggle();
                      },
                      child: (ishidden)
                          ? const Icon(
                              CupertinoIcons.eye_slash_fill,
                              color: Colors.grey,
                            )
                          : const Icon(
                              CupertinoIcons.eye_fill,
                              color: Colors.grey,
                            ),
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: SizeConfig.width - 20,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {
                      String email = _email.text.trim();
                      String pass = _pass.text.trim();

                      if (email.isEmpty || pass.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter All credentials")));
                      } else {
                        FirebaseAuthServices()
                            .loginAccount(email, pass, context);
                      }
                    },
                    child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        child: Text("Login")))),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have Account? ",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => CreateAccountView()),
                      (route) => false),
                  child: Text(
                    "Create Account",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
