import '../../../repositories/firebase_repository.dart';

class IsSignInUseCase {
  final FirebaseRepository firebaseRepository;
  IsSignInUseCase({required this.firebaseRepository});

  Future<bool> call() async {
    return firebaseRepository.isSignIn();
  }
}
