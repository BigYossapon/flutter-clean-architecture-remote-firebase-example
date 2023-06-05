import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:struccleancrudexam/src/data/datasources/remote/firebase_remote_datasource.dart';
import 'package:struccleancrudexam/src/data/datasources/remote/firebase_remote_datasurceImpl.dart';
import 'package:struccleancrudexam/src/data/repositories/firebase_repositoryImpl.dart';
import 'package:struccleancrudexam/src/domain/repositories/firebase_repository.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/delete_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_single_other_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/is_sign_in_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'package:struccleancrudexam/src/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/auth/auth_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/credential/credential_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/get_single_other_user/get_single_other_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/get_single_user/get_single_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/upload_avatar_user/upload_avatar_user_bloc.dart';
import 'package:struccleancrudexam/src/presentation/bloc-cubit/user/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
    //bloc
    () => AuthBloc(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UploadAvatarUserBloc(
        uploadImageToStorageUseCase: sl.call(),
        updateUserUseCase: sl.call(),
        getCurrentUidUseCase: sl.call()),
  );

  sl.registerFactory(
    () => CredentialBloc(
      signUpUserUseCase: sl.call(),
      signInUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(() => UserBloc(
      updateUserUseCase: sl.call(),
      getUsersUseCase: sl.call(),
      deleteUserUseCase: sl.call(),
      createUserUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));

  sl.registerFactory(
    () => GetSingleUserBloc(getSingleUserUseCase: sl.call()),
  );

  sl.registerFactory(
    () => GetSingleOtherUserBloc(getSingleOtherUserUseCase: sl.call()),
  );

  //usecase
  // User
  sl.registerLazySingleton(() => SignOutUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => IsSignInUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetCurrentUidUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => SignUpUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => SignInUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => UpdateUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetUsersUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => CreateUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetSingleUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => DeleteUserUseCase(firebaseRepository: sl.call()));
  sl.registerLazySingleton(
      () => GetSingleOtherUserUseCase(firebaseRepository: sl.call()));

  // Cloud Storage
  sl.registerLazySingleton(
      () => UploadImageToStorageUseCase(firebaseRepository: sl.call()));

  // Repository

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(firebaseRemoteDataSource: sl.call()));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          firebaseFirestore: sl.call(),
          firebaseAuth: sl.call(),
          firebaseStorage: sl.call()));

  // Externals

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
