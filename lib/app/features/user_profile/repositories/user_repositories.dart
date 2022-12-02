import 'package:acehnese_dictionary/app/constants/api.dart';
import 'package:acehnese_dictionary/app/features/user_profile/models/user_model.dart';
import 'package:acehnese_dictionary/app/utils/failure.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/services/rest_api_service.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> getUserProfile(String token);
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Either<Failure, UserModel>> getUserProfile(String token) async {
    final connectifityResult = await Connectivity().checkConnectivity();
    if (connectifityResult == ConnectivityResult.none) {
      return Left(ConnectionFailure("No Internet Connection"));
    }

    try {
      final response = await RestApiService().get(
        Api.baseUrl + ApiPath.authCheck(),
      );

      if (response.statusCode != 200) {
        return Left(ServerFailure(response.data['errors']));
      }

      final data = response.data['data'];
      if (data == null) {
        return Left(ServerFailure(response.data['meta']['message']));
      }

      final userModel = UserModel.fromJson(data);

      return Right(userModel);
    } catch (e) {
      return Left(ConnectionFailure(e.toString()));
    }
  }
}
