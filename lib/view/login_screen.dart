import 'package:flutter/material.dart';
import 'package:lingopanda/model/auth_provider.dart';
import 'package:lingopanda/res/components/button.dart';
import 'package:lingopanda/res/components/text_field.dart';
import 'package:lingopanda/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _formKeys = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
      @override
    void dispose() {
      emailController.dispose();
      passwordController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    
  
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          title:
              Text('Comments', style: Theme.of(context).textTheme.labelMedium),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKeys,
              child: Column(
                children: [
                  CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Enter valid Email';
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    isPassword: true,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Please Enter Password of min length 6';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.4,
            ),
            CustomButton(
              text: "Login",
              func: () async {
                if (_formKeys.currentState!.validate()) {
                  await Provider.of<AuthProviders>(context, listen: false)
                      .loginUser(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                }
              },
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.signup_screen);
              },
              child: RichText(
                  text: TextSpan(
                      text: "New Here? ",
                      style: Theme.of(context).textTheme.displaySmall,
                      children: [
                    TextSpan(
                        text: 'Signup',
                        style: Theme.of(context).textTheme.labelMedium)
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
