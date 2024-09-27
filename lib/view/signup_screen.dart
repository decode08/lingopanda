import 'package:flutter/material.dart';
import 'package:lingopanda/model/auth_provider.dart';
import 'package:lingopanda/res/components/button.dart';
import 'package:lingopanda/res/components/text_field.dart';
import 'package:lingopanda/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: nameController,
                      hintText: "Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter your email';
                        } else
                          return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                      isPassword: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Please enter password minimum of length: 6';
                        } else
                          return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.4),
              CustomButton(
                  text: "Signup",
                  func: () async {
                    if (_formKey.currentState!.validate()) {
                      await Provider.of<AuthProviders>(context, listen: false)
                          .signupUser(
                        emailController.text,
                        passwordController.text,
                        nameController.text,
                        context,
                      );
                    }
                  }),
              SizedBox(height: size.height * 0.01),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.login_screen);
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.displaySmall,
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
