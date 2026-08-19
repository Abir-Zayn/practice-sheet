import 'package:equatable/equatable.dart';
import 'package:mockai/core/utils/typedefs.dart';

abstract class Usecases<ReturnType, Params>{
  ResultFuture<ReturnType> call(Params params);
}

class NoParams extends Equatable{
  const NoParams();

  @override
  List<Object?> get props => [];
}