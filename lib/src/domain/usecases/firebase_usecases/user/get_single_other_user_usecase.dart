import '../../../entities/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class GetSingleOtherUserUseCase {
  final FirebaseRepository firebaseRepository;
  GetSingleOtherUserUseCase({required this.firebaseRepository});

  Future<UserEntity> call(String otheruid) {
    return firebaseRepository.getSingleOtherUser(otheruid);
  }
}
