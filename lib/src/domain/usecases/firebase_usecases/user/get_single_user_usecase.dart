import '../../../entities/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class GetSingleUserUseCase {
  final FirebaseRepository firebaseRepository;
  GetSingleUserUseCase({required this.firebaseRepository});

  Stream<UserEntity> call(String uid) {
    return firebaseRepository.getSingleUser(uid);
  }
}
