import 'package:git_users/domain/model/user_domain.dart';

import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/presentation/model/user_item.dart';
import 'base_usecase.dart';

class AddUsersUseCase
    extends BaseUseCase<void, GetHiveUsersUseCaseParams> {
  final UserRepository _repository;

  AddUsersUseCase(this._repository);

  @override
  Future<void> buildUseCaseFuture({GetHiveUsersUseCaseParams params}) async {

    final result = await _repository.insertUsers(params.users.mapToUserListItem());
    return result.PresentationToDomain();

  }
}


class GetHiveUsersUseCaseParams {
  List<UserItem> users;
  GetHiveUsersUseCaseParams(this.users);
}
