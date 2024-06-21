
import 'package:baraneq/config/database/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepositort{
   Future<Either<Failure,Map<String, double>>> getTanks();
}