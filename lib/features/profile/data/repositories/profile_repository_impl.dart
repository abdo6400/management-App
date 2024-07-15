
import 'package:baraneq/features/profile/data/datasources/profile_local_data_source.dart';



import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileLocalDataSource _dataSource;

  ProfileRepositoryImpl({required ProfileLocalDataSource dataSource})
      : _dataSource = dataSource;

  
}
