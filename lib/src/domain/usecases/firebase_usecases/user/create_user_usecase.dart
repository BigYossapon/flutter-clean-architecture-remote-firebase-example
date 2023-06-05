import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';

import '../../../repositories/firebase_repository.dart';

class CreateUserUseCase {
  final FirebaseRepository firebaseRepository;
  CreateUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity userEntity) async {
    return firebaseRepository.createUser(userEntity);
  }
}
