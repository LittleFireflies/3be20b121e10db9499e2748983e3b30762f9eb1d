// Mocks generated by Mockito 5.0.15 from annotations
// in kulina_app/test/data/repositories/product_repositpry_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:kulina_app/data/datasources/api_service.dart' as _i2;
import 'package:kulina_app/data/models/product_dto.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i2.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.ProductDTO>> getProducts() => (super.noSuchMethod(
          Invocation.method(#getProducts, []),
          returnValue: Future<List<_i4.ProductDTO>>.value(<_i4.ProductDTO>[]))
      as _i3.Future<List<_i4.ProductDTO>>);
  @override
  String toString() => super.toString();
}