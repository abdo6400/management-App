import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/bloc/usecases/usecase.dart';
import '../../../../core/entities/client.dart';
import '../repositories/invoices_repository.dart';

class AccountStatementWithFiltersUsecase
    implements UseCase<List<Client>, InvoicesFilters> {
  final InvoicesRepository _repository;

  AccountStatementWithFiltersUsecase({required InvoicesRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, List<Client>>> call(InvoicesFilters params) =>
      _repository.accoutStatementWithFilters(filters: params.filters);
}

class InvoicesFilters {
  final Map<String, dynamic> filters;

  InvoicesFilters({required this.filters});
}
