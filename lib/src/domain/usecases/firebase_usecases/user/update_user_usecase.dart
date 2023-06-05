import 'package:struccleancrudexam/src/domain/entities/user_entity.dart';

import '../../../repositories/firebase_repository.dart';

class UpdateUserUseCase {
  final FirebaseRepository firebaseRepository;
  UpdateUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity userEntity) async {
    return firebaseRepository.updateUser(userEntity);
  }
}
