import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kulina_app/data/datasources/api_service.dart';
import 'package:kulina_app/data/datasources/database.dart';
import 'package:kulina_app/data/models/product_dto.dart';
import 'package:kulina_app/data/repositories/product_repository_impl.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/utils/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_repositpry_impl_test.mocks.dart';

@GenerateMocks([ApiService, Database])
void main() {
  final testProductDto = ProductDTO(
    id: 1,
    name: 'name',
    imageUrl: 'imageUrl',
    brandName: 'brandName',
    packageName: 'packageName',
    price: 10000,
    rating: 1.2,
  );
  final testProductDtoList = [testProductDto];

  final testProduct = Product(
    1,
    'name',
    'imageUrl',
    'brandName',
    'packageName',
    10000,
    1.2,
  );
  final testProductList = [testProduct];

  late MockApiService mockApiService;
  late MockDatabase mockDatabase;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockApiService = MockApiService();
    mockDatabase = MockDatabase();
    repository = ProductRepositoryImpl(
      apiService: mockApiService,
      database: mockDatabase,
    );
  });

  test(
    'should return API data when call to API Service is success',
    () async {
      // arrange

      when(mockApiService.getProducts())
          .thenAnswer((_) async => testProductDtoList);
      // act
      final result = await repository.getProductList();
      // assert
      verify(mockApiService.getProducts());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testProductList);
    },
  );

  test(
    'should return ServerFailure when call to API Service is unsuccess',
    () async {
      // arrange
      when(mockApiService.getProducts()).thenThrow(Exception());
      // act
      final result = await repository.getProductList();
      // assert
      verify(mockApiService.getProducts());
      expect(result, Left(ServerFailure('')));
    },
  );
}
