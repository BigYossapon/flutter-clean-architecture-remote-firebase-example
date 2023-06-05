import '../../../repositories/firebase_repository.dart';

class DeleteUserUseCase {
  final FirebaseRepository firebaseRepository;
  DeleteUserUseCase({required this.firebaseRepository});

  Future<void> call(String uid) async {
    return firebaseRepository.deleteUser(uid);
  }
}
