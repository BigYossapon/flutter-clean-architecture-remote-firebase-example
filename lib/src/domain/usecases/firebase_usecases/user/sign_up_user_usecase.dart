import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';

import '../../../repositories/firebase_repository.dart';

class SignUpUserUseCase {
  final FirebaseRepository firebaseRepository;
  SignUpUserUseCase({required this.firebaseRepository});

  Future<String?> call(UserEntity userEntity) async {
    return firebaseRepository.signUpUser(userEntity);
  }
}
