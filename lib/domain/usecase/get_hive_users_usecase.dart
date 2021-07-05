import 'package:git_users/domain/model/user_domain.dart';

import 'package:git_users/domain/repository/user_repository.dart';
import 'package:git_users/presentation/model/user_item.dart';

import 'base_usecase.dart';

class GetHiveUsersUseCase
    extends BaseUseCase<List<UserItem>, GetUsersUseCaseParams> {
  final UserRepository _repository;

  GetHiveUsersUseCase(this._repository);

  @override
  Future<List<UserItem>> buildUseCaseFuture({GetUsersUseCaseParams params}) async {
    List<UserDomain> userDomainList = await _repository.fetchHiveUser();
    return userDomainList.mapToUserListItem();
  }
}

class GetUsersUseCaseParams {
}
