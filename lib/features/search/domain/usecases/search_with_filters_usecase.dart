import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../../../../core/entities/client.dart';
import '../repositories/search_repository.dart';

class SearchWithFiltersUsecase implements UseCase<List<Client>, SearchFilters> {
  final SearchRepository _repository;

  SearchWithFiltersUsecase({required SearchRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Client>>> call(SearchFilters params) =>
      _repository.searchWithFilters(filters: params.filters);
}

class SearchFilters {
  final Map<String, dynamic> filters;

  SearchFilters({required this.filters});
}
