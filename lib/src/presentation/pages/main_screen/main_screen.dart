import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/get_single_user/get_single_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/pages/setting/setting_page.dart';
import 'package:struccleancrudexam/src/utils/shared/secure_storage/user_secure_storage.dart';
import 'package:struccleancrudexam/src/utils/shared/share_preferences/user_share_preference.dart';

import '../../bloc-cubit/user/get_single_other_user/get_single_other_user_bloc.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class MainScreen extends StatefulWidget {
  final String uid;
  const MainScreen({super.key, required this.uid});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String email = "";
  String password = "";
  String uid = "BYv1msWXHfRoCEJNfaniwQlBDkS2";
  late PageController pageController;

  @override
  void initState() {
    // UserSecureStorage.setEmail(email);
    // UserSecureStorage.setPassword(password);
    // UserSecureStorage.getEmail().then((value) => email = value!);

    // UserSecureStorage.getPassword().then((value) => password = value!);

    // final userEntity = UserEntity(email: email, password: password, uid: uid);
    // BlocProvider.of<UserBloc>(context)
    //     .add(CreateUserEvent(userEntity: userEntity));
    BlocProvider.of<GetSingleOtherUserBloc>(context)
        .add(GetSingleOtherUser_Event(otherUid: uid));

    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleOtherUserBloc, GetSingleOtherUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleOtherUserLoadedState) {
          final currentUser = getSingleUserState.otherUser;
          return Scaffold(
            backgroundColor: Colors.greenAccent,
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: Colors.lime,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
              ],
              onTap: navigationTapped,
            ),
            body: PageView(
              controller: pageController,
              children: [
                HomePage(),
                ProfilePage(
                  userEntity: currentUser,
                ),
                SettingPage()
              ],
              onPageChanged: onPageChanged,
            ),
          );
        }
        return Center(
          // child: Text(""),
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
