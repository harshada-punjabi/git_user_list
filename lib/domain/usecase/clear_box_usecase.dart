
import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/presentation/model/user_item.dart';

import 'base_usecase.dart';

class DeleteAllUserUseCase
    extends BaseUseCase<void, DeleteAllUserUseCaseParams> {
  final UserRepository _repository;

  DeleteAllUserUseCase(this._repository);

  @override
  Future<void> buildUseCaseFuture({DeleteAllUserUseCaseParams params}) async {
    final result = await _repository.clearDataBase();
    return result;
  }
}


class DeleteAllUserUseCaseParams{
}
