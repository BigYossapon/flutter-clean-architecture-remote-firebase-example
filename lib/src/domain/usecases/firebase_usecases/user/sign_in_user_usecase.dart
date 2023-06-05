import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';

import '../../../repositories/firebase_repository.dart';

class SignInUserUseCase {
  final FirebaseRepository firebaseRepository;
  SignInUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity userEntity) async {
    return firebaseRepository.signInUser(userEntity);
  }
}
