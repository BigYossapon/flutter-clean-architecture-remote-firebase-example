import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/auth/auth_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/credential/credential_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/pages/credential/sign_up_page.dart';
import 'package:string_validator/string_validator.dart';
import 'package:struccleancrudexam/src/utils/shared/secure_storage/user_secure_storage.dart';

import '../main_screen/main_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  //late RequestLoginModel requestLoginModel;

  @override
  void dispose() {
    email.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    password.dispose();

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
                      validator: (value) {
                        bool isemail = isEmail(value!);
                        if (value!.isEmpty) {
                          return 'Input cannot be empty!';
                        } else if (isemail) {
                          return 'Input Email!';
                        }
                        return null;
                      },
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
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is CredentialLoadingState) {
                        _Loading(context);
                      }

                      if (state is CredentialFailureState) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: "Login Failure please try again!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                      if (state is CredentialSuccessState) {
                        Navigator.pop(context);
                        BlocProvider.of<AuthBloc>(context).add(LoggedInEvent());
                        BlocListener<AuthBloc, AuthState>(
                            listener: (context, state) {
                              // TODO: implement listener
                              if (state is AuthenticatedState) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => MainScreen(
                                              uid: state.uid,
                                            )));
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
                                    String pw = password.text;

                                    // final requestLoginModel = RequestModel(
                                    //     username: username.text, password: pw);
                                    // requestLoginModel.username = username.text;
                                    // requestLoginModel.password = password.text;
                                    UserSecureStorage.setEmail(email.text);
                                    UserSecureStorage.setPassword(pw);
                                    final userEntity = UserEntity();
                                    context
                                        .read<CredentialBloc>()
                                        .add(SignInUserEvent(email.text, pw));
                                    context.read<UserBloc>().add(
                                        CreateUserEvent(
                                            userEntity: userEntity));

                                    _formKey.currentState!.reset();
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ));
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
                            String pw = password.text;

                            // final requestLoginModel = RequestModel(
                            //     username: username.text, password: pw);
                            // requestLoginModel.username = username.text;
                            // requestLoginModel.password = password.text;
                            UserSecureStorage.setEmail(email.text);
                            UserSecureStorage.setPassword(pw);
                            final userEntity = UserEntity();
                            context
                                .read<CredentialBloc>()
                                .add(SignInUserEvent(email.text, pw));
                            // context
                            //     .read<UserBloc>()
                            //     .add(CreateUserEvent(userEntity: userEntity));

                            _formKey.currentState!.reset();
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text("--------------Don't have an Account?-------------"),
                  Container(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          print('Form Complete');
                          _formKey.currentState!.save();

                          // final requestLoginModel = RequestModel(
                          //     username: username.text, password: pw);
                          // requestLoginModel.username = username.text;
                          // requestLoginModel.password = password.text;

                          // context
                          //     .read<PostLoginBloc>()
                          //     .add(LoginEvent(requestLoginModel));
                        }
                      },
                      child: const Text(
                        'Login with Google',
                        style: TextStyle(color: Colors.blue, fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      //TODO FORGOT PASSWORD SCREEN GOES HERE
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ])));
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
