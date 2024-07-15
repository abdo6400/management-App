import 'package:dartz/dartz.dart';
import '../../../../config/database/error/failures.dart';
import '../../../../core/entities/client.dart';
import '../../../../core/entities/search_client.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Client>>> getDailyClients(
      {required Map<String, dynamic> options});
  Future<Either<Failure, List<SearchClient>>> searchAboutClient(
      {required Map<String, dynamic> filters});
  Future<Either<Failure, Map<String, dynamic>>> getBalance();

  Future<Either<Failure, bool>> addReceipt(
      {required Map<String, dynamic> receipt});
  Future<Either<Failure, bool>> editReceipt(
      {required Map<String, dynamic> receipt});
  Future<Either<Failure, bool>> deleteReceipt({required int id});

  Future<Either<Failure, List<Map<String, dynamic>>>> getTanksInformation(
      {required Map<String, dynamic> options});
}
