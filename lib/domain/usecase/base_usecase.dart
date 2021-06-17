
import 'package:flutter/material.dart';

/// T is the response type for presentation layer
/// Params are the params needed to build & execute the use case
abstract class BaseUseCase<T, Params> {
  Future<T> buildUseCaseFuture({@required Params params}) {}

  Stream<T> buildUseCaseObservable({@required Params params}) {}
}

class BaseUseCaseParams{}