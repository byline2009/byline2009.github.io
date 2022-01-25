import 'package:bloc_login/data_layer/models/category_response.dart';

abstract class CategoryState {
  final CategoryResponse? categoryResponse;
  final String? error;
  CategoryState({this.categoryResponse, this.error});
}

class CategoryStateDefault extends CategoryState {}

// login state
class CategoryStateLoading extends CategoryState {
  CategoryStateLoading();
}

class CategoryStateSuccess extends CategoryState {
  CategoryStateSuccess({required CategoryResponse categoryResponse})
      : super(categoryResponse: categoryResponse);
}

class CategoryStateError extends CategoryState {
  CategoryStateError({required String error}) : super(error: error);
}
