import 'package:baraneq/features/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';

import '../../../../core/entities/search_client.dart';

class SearchAboutClientUsecase
    implements UseCase<List<SearchClient>, SearchFilters> {
  final SearchRepository _repository;

  SearchAboutClientUsecase({required SearchRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<SearchClient>>> call(SearchFilters filters) =>
      _repository.searchWithNameAboutClient(filters: filters.filters);
}

class SearchFilters {
  final Map<String, dynamic> filters;

  SearchFilters({required this.filters});
}
