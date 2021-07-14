
import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/presentation/model/user_item.dart';

import 'base_usecase.dart';

class DeleteUserUseCase
    extends BaseUseCase<void, DeleteUserUseCaseParams> {
  final UserRepository _repository;

  DeleteUserUseCase(this._repository);

  @override
  Future<void> buildUseCaseFuture({DeleteUserUseCaseParams params}) async {
    final result = await _repository.deleteUser(params.index);
    return result;
  }
}


class DeleteUserUseCaseParams{
  int index;
  DeleteUserUseCaseParams(this.index);
}
