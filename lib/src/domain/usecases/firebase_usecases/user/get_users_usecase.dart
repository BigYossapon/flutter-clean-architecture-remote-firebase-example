import '../../../entities/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FirebaseRepository firebaseRepository;
  GetUsersUseCase({required this.firebaseRepository});

  Stream<List<UserEntity>> call() {
    return firebaseRepository.getUsers();
  }
}
