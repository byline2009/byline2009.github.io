import 'package:bloc_login/data_layer/models/category_response.dart';
import 'package:flutter/cupertino.dart';

abstract class CategoryEvent {}

class GetCategoryList extends CategoryEvent {
  final BuildContext context;
  GetCategoryList({required this.context});
}
