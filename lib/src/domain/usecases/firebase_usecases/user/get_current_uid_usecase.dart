import '../../../repositories/firebase_repository.dart';

class GetCurrentUidUseCase {
  final FirebaseRepository firebaseRepository;
  GetCurrentUidUseCase({required this.firebaseRepository});

  Future<String> call() async {
    return firebaseRepository.getCurrentUid();
  }
}
