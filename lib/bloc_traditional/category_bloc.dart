import 'package:bloc_login/bloc_cubit/auth_cubit.dart';
import 'package:bloc_login/bloc_traditional/category_event.dart';
import 'package:bloc_login/bloc_traditional/category_state.dart';
import 'package:bloc_login/models/category_response.dart';
import 'package:bloc_login/services/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc(CategoryState initialState) : super(initialState) {
    on<GetCategoryList>((event, emit) async {
      emit(CategoryStateLoading());
      AuthenticationService _authenticationService =
          Provider.of(event.context, listen: false);

      CategoryResponse _categoryResponse =
          await _authenticationService.getCategories({});
      if (_categoryResponse.error.isEmpty) {
        emit(CategoryStateSuccess(categoryResponse: _categoryResponse));
      } else {
        emit(CategoryStateError(error: _categoryResponse.error));
      }
    });
  }
}
