import 'package:bloc_login/models/category_response.dart';
import 'package:bloc_login/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/subjects.dart';

class CategoriesListBloc {
  final BehaviorSubject<CategoryResponse> _subject =
      BehaviorSubject<CategoryResponse>();

  getCategories(dynamic context) async {
    AuthenticationService _authenticationService =
        Provider.of(context, listen: false);
    CategoryResponse _categoryResponse =
        await _authenticationService.getCategories({});
    _subject.sink.add(_categoryResponse);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CategoryResponse> get subject => _subject;
}

final categoriesBloc = CategoriesListBloc();
