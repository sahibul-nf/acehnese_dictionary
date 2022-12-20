import 'package:acehnese_dictionary/app/features/auth/respositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/mocks.dart';

void main() {
  late AuthRepositoryImpl authRepository;
  MockRestApiService? mockRestApiService;

  setUp(() {
    authRepository = AuthRepositoryImpl(restApiService: mockRestApiService);
  });

  group('SignIn Test', () {
    // test('should return AuthModel when sign in successfully', () async {
    //   // arrange
    //   when(() => mockRestApiService!.postDio(any(), body: any(named: 'body')))
    //       .thenAnswer((_) async => Response(
    //             requestOptions: RequestOptions(path: ''),
    //             data: {
    //               'data': {},
    //               'meta': {
    //                 'message': 'Sign in successfully',
    //               },
    //             },
    //           ));

    //   // act
    //   final result = await authRepository.signIn(
    //       email: 'sahibul@gmail.com', password: 'sahibul');

    //   // assert
    //   expect(result, isA<AuthModel>());
    // });

    test('should return ConnectionFailure when internet connection is lost',
        () async {
      // arrange
      // act
      // assert
    });

    test('should throw ServerFailure when server error occurs', () async {
      // arrange
      // act
      // assert
    });
  });
}
