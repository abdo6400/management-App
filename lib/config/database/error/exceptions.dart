import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String errorMessage;

  const ServerException(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];

  @override
  String toString() {
    return errorMessage;
  }
}

class ParamterErrorException extends ServerException {
  final List<dynamic> errors;
  ParamterErrorException(this.errors)
      : super(errors.map((e) => e["errorMessage"]).toList().join());
}

class FetchDataException extends ServerException {
  const FetchDataException(super.errorMessage);
}

class BadRequestException extends ServerException {
  const BadRequestException(super.errorMessage);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException(super.errorMessage);
}

class NotFoundException extends ServerException {
  const NotFoundException(super.errorMessage);
}

class ConflictException extends ServerException {
  const ConflictException(super.errorMessage);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException(super.errorMessage);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException(super.errorMessage);
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}
