import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/auth/auth_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/credential/credential_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/get_single_other_user/get_single_other_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/get_single_user/get_single_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/upload_avatar_user/upload_avatar_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/pages/credential/sign_in_page.dart';
import 'package:struccleancrudexam/src/presentation/pages/main_screen/main_screen.dart';
import 'package:struccleancrudexam/src/utils/app_bloc_observe.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      //await configureDependencies();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await di.init();
      runApp(const MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()..add(AppStartedEvent())),
        BlocProvider(create: (_) => di.sl<CredentialBloc>()),
        BlocProvider(create: (_) => di.sl<UserBloc>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserBloc>()),
        BlocProvider(create: (_) => di.sl<GetSingleOtherUserBloc>()),
        BlocProvider(create: (_) => di.sl<UploadAvatarUserBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter CRUD User',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            if (authState is AuthenticatedState) {
              return MainScreen(
                uid: authState.uid,
              );
            } else {
              return const SignInPage();
            }
          },
        ),
      ),
    );
  }
}
