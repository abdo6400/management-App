import 'package:baraneq/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

import '../../../../core/entities/search_client.dart';

class SearchAboutClientUsecase implements UseCase<List<SearchClient>, SearchFilters> {
  final HomeRepository _repository;

  SearchAboutClientUsecase({required HomeRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<SearchClient>>> call(SearchFilters filters) =>
      _repository.searchAboutClient(filters: filters.filters);
}

class SearchFilters {
  final Map<String, dynamic> filters;

  SearchFilters({required this.filters});
}
