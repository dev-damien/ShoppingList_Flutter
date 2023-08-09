import 'package:dartz/dartz.dart';
import 'package:shoppinglist/03_domain/entities/user_data.dart';
import 'package:shoppinglist/03_domain/repositories/user_repository.dart';
import 'package:shoppinglist/core/failures/user_failures.dart';

class UserUsecases {
  final UserRepository userRepository;

  UserUsecases({
    required this.userRepository,
  });

  Stream<Either<UserFailure, UserData>> watch() {
    return userRepository.watch();
  }
}
