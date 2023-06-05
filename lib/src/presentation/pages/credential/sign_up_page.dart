import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/pages/credential/sign_in_page.dart';
import 'package:struccleancrudexam/src/utils/shared/secure_storage/user_secure_storage.dart';

import '../../bloc-cubit/credential/credential_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  final password = TextEditingController();

  //final avartar = TextEditingController();

  @override
  void dispose() {
    // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    password.dispose();
    email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: email,
                validator: (value) =>
                    value!.isEmpty ? 'Input cannot be empty!' : null,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // เมื่อ focus
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // สถานะปกติ
                    borderSide: BorderSide(width: 1.0), // กำหนดสีในนี้ได้
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: password,
                validator: (value) =>
                    value!.isEmpty ? 'Input cannot be empty!' : null,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // เมื่อ focus
                    borderSide: BorderSide(width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    // สถานะปกติ
                    borderSide: BorderSide(width: 1.0), // กำหนดสีในนี้ได้
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            BlocListener<CredentialBloc, CredentialState>(
              listener: (context, state) async {
                // TODO: implement listener
                if (state is CredentialLoadingState) {
                  _Loading(context);
                }
                if (state is CredentialFailureState) {
                  Navigator.pop(context);
                }
                if (state is CredentialSuccessState) {
                  //Navigator.of(context).pop();
                  final email = await UserSecureStorage.getEmail();
                  final password = await UserSecureStorage.getPassword();
                  final userEntity = UserEntity(
                      email: email, password: password, uid: state.uid);
                  context
                      .read<UserBloc>()
                      .add(CreateUserEvent(userEntity: userEntity));
                  BlocListener<UserBloc, UserState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is UserLoadingState) {
                        // _Loading(context);
                      }
                      if (state is UserFailureState) {
                        Navigator.of(context).pop();
                      }

                      if (state is UserLoadedState) {
                        Navigator.of(context).pop();

                        final snackBar = SnackBar(content: Text("success"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignInPage()));
                      }
                    },
                    child: Container(),
                  );
                }
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print('Form Complete');
                      _formKey.currentState!.save();
                      _dialogRegister(context, password.text, email.text);
                      _formKey.currentState!.reset();
                    }
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            Container(
              height: 5,
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
                Navigator.pop(context);
              },
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _Loading(BuildContext context) async {
  // show the loading dialog
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                // Some text
                Text('Loading...')
              ],
            ),
          ),
        );
      });
}

void _dialogRegister(
  BuildContext buildcontext,
  String password,
  String email,
) async {
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: buildcontext,
      builder: (context) => AlertDialog(
            title: const Text('Register'),
            content: const Text('Comfirm to Register?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(buildcontext),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final userEntity = UserEntity(
                      password: password,
                      email: email,
                    );
                    UserSecureStorage.setEmail(email);
                    UserSecureStorage.setPassword(password);
                    buildcontext
                        .read<CredentialBloc>()
                        .add(SignUpUserEvent(userEntity: userEntity));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'))
            ],
          ));
}
