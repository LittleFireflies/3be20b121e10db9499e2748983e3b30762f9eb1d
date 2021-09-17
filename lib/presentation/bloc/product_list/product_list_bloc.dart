import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kulina_app/domain/entities/product.dart';
import 'package:kulina_app/domain/usecases/get_product_list.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductList getProductList;

  ProductListBloc(this.getProductList) : super(EmptyProductList());

  @override
  Stream<ProductListState> mapEventToState(
    ProductListEvent event,
  ) async* {
    if (event is LoadProductList) {
      yield LoadingProductList();

      final result = await getProductList.execute();

      yield* result.fold(
        (failure) async* {
          yield ProductListError(failure.message);
        },
        (data) async* {
          yield ProductListHasData(data);
        },
      );
    }
  }
}
