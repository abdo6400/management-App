import 'package:baraneq/features/client/domain/entities/client_information.dart';
import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';

abstract class ClientRepository {
  Future<Either<Failure, bool>> addClient(
      {required Map<String, dynamic> client});

  Future<Either<Failure, bool>> deleteClient({required int id});

  Future<Either<Failure, bool>> updateClient(
      {required Map<String, dynamic> client});

  Future<Either<Failure, List<ClientInformation>>> getClients({required Map<String, dynamic> options});
}
