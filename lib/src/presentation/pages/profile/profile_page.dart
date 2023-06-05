import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/presentation/pages/credential/sign_in_page.dart';

import '../../../utils/shared/share_preferences/user_share_preference.dart';
import '../../bloc-cubit/user/upload_avatar_user/upload_avatar_user_bloc.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity userEntity;
  const ProfilePage({super.key, required this.userEntity});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();
  final country = TextEditingController();

  @override
  void dispose() {
    username.dispose(); // ยกเลิกการใช้งานที่เกี่ยวข้องทั้งหมดถ้ามี
    password.dispose();
    email.dispose();
    address.dispose();
    country.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    // username.text = (await UserSharedPreferences.getUsername())!;
    //  email.text = (await UserSharedPreferences.getEmail())!;
    //  address.text = (await UserSharedPreferences.getAddress())!;
    //  country.text = (await UserSharedPreferences.getCountry())!;
    //  avartar = (await UserSharedPreferences.getAvartar())!;
    if (widget.userEntity.email != null) {
      email.text = widget.userEntity.email!;
    }
    if (widget.userEntity.username != null) {
      username.text = widget.userEntity.username!;
    }
    if (widget.userEntity.password != null) {
      password.text = widget.userEntity.password!;
    }
    if (widget.userEntity.address != null) {
      address.text = widget.userEntity.address!;
    }
    if (widget.userEntity.country != null) {
      country.text = widget.userEntity.country!;
    }

    super.initState();
    getUserSharedpreferences();
  }

  Future getUserSharedpreferences() async {
    // await UserSharedPreferences.getUsername().then((value) {
    //   setState(() {
    //     username.text = value!;
    //   });
    // });

    // await UserSharedPreferences.getEmail().then((value) {
    //   setState(() {
    //     email.text = value!;
    //   });
    // });

    // await UserSharedPreferences.getAddress().then((value) {
    //   setState(() {
    //     address.text = value!;
    //   });
    // });

    // await UserSharedPreferences.getCountry().then((value) {
    //   setState(() {
    //     country.text = value!;
    //   });
    // });

    // await UserSharedPreferences.getAvartar().then((value) {
    //   setState(() {
    //     avartar = value!;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 5.0,
            ),
            BlocBuilder<UploadAvatarUserBloc, UploadAvatarUserState>(
              builder: (context, state) {
                if (state is UploadingAvatarUserState) {
                  return const CircularProgressIndicator();
                } else if (state is UploadedAvatarUserState) {
                  return Container(
                      child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(state.avatar),
                  ));
                }
                return Container(
                    child: widget.userEntity.avatar == null
                        ? SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              'assets/images/placeholder.png',
                              fit: BoxFit.cover,
                            ))
                        : CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                NetworkImage(widget.userEntity.avatar!),
                          ));
              },
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                    requestGalleryPermission(context);
                  },
                  child: const Text(
                    'Upload Avartar from Gallery',
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //TODO FORGOT PASSWORD SCREEN GOES HERE
                    requestCameraPermission(context);
                  },
                  child: const Text(
                    'Upload Avartar from Camera',
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: username,
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
                  labelText: 'Username',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                readOnly: true,
                enabled: false,
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
                controller: address,
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
                  labelText: 'Address',
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
                controller: country,
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
                  labelText: 'Country',
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print('Form Complete');
                    _formKey.currentState!.save();

                    _dialogEdit(context, username.text, password.text,
                        address.text, country.text, email.text);
                  }
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 5,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  _dialogDelete(context);
                },
                child: const Text(
                  'Delete Profile',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 5,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async {
                  _dialoglogout(context);
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
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

void _dialoglogout(BuildContext buildcontext) {
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: buildcontext,
      builder: (context) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Comfirm to Logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    // await UserSecureStorage.setToken("");
                    await UserSharedPreferences.setAddress("");
                    await UserSharedPreferences.setUsername("");
                    await UserSharedPreferences.setAvartar("");
                    await UserSharedPreferences.setCountry("");
                    await UserSharedPreferences.setEmail("");
                    await UserSharedPreferences.setId("");
                    await UserSharedPreferences.setRoles([""]);
                    //UserSharedPreferences.password("");
                    Navigator.pop(context);
                    Navigator.push(
                      buildcontext,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                    );
                  },
                  child: const Text('Confirm'))
            ],
          ));
}

void _dialogDelete(BuildContext buildcontext) {
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: buildcontext,
      builder: (context) => AlertDialog(
            title: const Text('Delete'),
            content: const Text('Comfirm to Delete Account?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    String? id = await UserSharedPreferences.getId();
                    String? username =
                        await UserSharedPreferences.getUsername();
                    // final requestDeleteProfileModel =
                    //     RequestDeleteProfileModel(id: id, username: username);
                    Navigator.pop(context);
                    // buildcontext.read<DeleteProfileBloc>().add(
                    //     Delete_ProfileEvent(requestDeleteProfileModel, id!));
                  },
                  child: const Text('Confirm'))
            ],
          ));
}

void _dialogEdit(BuildContext buildcontext, String username, String password,
    String address, String country, String email) {
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: buildcontext,
      builder: (context) => AlertDialog(
            title: const Text('Register'),
            content: const Text('Comfirm to Register?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    // final requestEditProfileModel = RequestEditProfileModel(
                    //     username: username,
                    //     password: password,
                    //     address: address,
                    //     avartar: avartar,
                    //     country: country,
                    //     email: email);

                    //String? id = await UserSharedPreferences.getId();
                    Navigator.pop(context);
                    // buildcontext
                    //     .read<PutProfileBloc>()
                    //     .add(EditProfileEvent(requestEditProfileModel, id!));
                  },
                  child: const Text('Confirm'))
            ],
          ));
}

Future requestCameraPermission(BuildContext buildContext) async {
  /// status can either be: granted, denied, restricted or permanentlyDenied
  var status = await Permission.camera.status;
  if (status.isGranted) {
    print("Permission is granted");
    pickAvartar(ImageSource.camera, buildContext);
  } else if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    if (await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print("Permission was granted");
    }
  }
}

Future requestGalleryPermission(BuildContext buildContext) async {
  /// status can either be: granted, denied, restricted or permanentlyDenied
  var status = await Permission.storage.status;
  if (status.isGranted) {
    print("Permission is granted");
    pickAvartar(ImageSource.gallery, buildContext);
  } else if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    if (await Permission.storage.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      print("Permission was granted");
    }
  }
}

Future pickAvartar(ImageSource imageSource, BuildContext buildContext) async {
  try {
    final uploadImage = await ImagePicker().pickImage(source: imageSource);
    if (uploadImage == null) return;
    final imageTemp = File(uploadImage.path);
    buildContext
        .read<UploadAvatarUserBloc>()
        .add(UploadAvatarUser_Event(avatar: imageTemp));
    // buildContext
    //     .read<PickerAvartarProfileBloc>()
    //     .add(PickerAvartarEvent(imageTemp));
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
}
