// Mocks generated by Mockito 5.0.15 from annotations
// in kulina_app/test/domain/usecases/get_product_list_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:kulina_app/domain/entities/product.dart' as _i6;
import 'package:kulina_app/domain/repositories/product_repository.dart' as _i3;
import 'package:kulina_app/utils/failure.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [ProductRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductRepository extends _i1.Mock implements _i3.ProductRepository {
  MockProductRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Product>>> getProductList() =>
      (super.noSuchMethod(Invocation.method(#getProductList, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Product>>>.value(
              _FakeEither_0<_i5.Failure, List<_i6.Product>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Product>>>);
  @override
  String toString() => super.toString();
}
