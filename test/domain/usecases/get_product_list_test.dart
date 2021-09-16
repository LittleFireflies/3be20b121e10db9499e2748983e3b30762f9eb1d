import 'package:flutter_test/flutter_test.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/repositories/product_repository.dart';
import 'package:kulina_app/domain/usecases/get_product_list.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_product_list_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  final testProduct = Product(
    1,
    'name',
    'imageUrl',
    'brandName',
    'packageName',
    10000,
    4.4,
  );
  final testProductList = [testProduct];

  test(
    'should get list of products from repository when executed',
    () async {
      // arrange
      final mockProductRepository = MockProductRepository();
      final usecase = GetProductList(mockProductRepository);
      when(mockProductRepository.getProductList())
          .thenAnswer((_) async => testProductList);
      // act
      final result = await usecase.execute();
      // assert
      expect(result, testProductList);
    },
  );
}
