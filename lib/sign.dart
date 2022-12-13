import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watsapcloneee/core/locator.dart';
import 'package:watsapcloneee/viewModels/sign_in_model.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  TextEditingController userNamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (BuildContext context) {
      getIt<SignInModel>();
    }, child: Consumer<SignInModel>(
      builder: (BuildContext context, SignInModel model, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign In'),
          ),
          body: Center(
            child: model.isBusy
                ? CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign In',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Username',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'User Name',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () async {
                            await model.signIn(userNamecontroller.text);
                          },
                          child: const Text('Sign In'),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    ));
  }
}
