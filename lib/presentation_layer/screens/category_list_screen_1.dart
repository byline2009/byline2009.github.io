import 'package:bloc_login/bloc_layer/bloc_traditional/category_bloc.dart';
import 'package:bloc_login/bloc_layer/bloc_traditional/category_event.dart';
import 'package:bloc_login/bloc_layer/bloc_traditional/category_state.dart';
import 'package:bloc_login/data_layer/models/category.dart';
import 'package:bloc_login/data_layer/models/category_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CategoryListScreen1 extends StatefulWidget {
  const CategoryListScreen1({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen1> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      CategoryBloc _categoryBloc = Provider.of(context, listen: false);
      _categoryBloc.add(GetCategoryList(context: context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, snapshot) {
            if (snapshot is CategoryStateSuccess) {
              return _buildListCategory(snapshot.categoryResponse!);
            } else if (snapshot is CategoryStateError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        SizedBox(height: 25, child: CircularProgressIndicator())
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(child: Text("$error"));
  }

  Widget _buildListCategory(CategoryResponse data) {
    List<Category> categories = data.categories;
    if (categories.isEmpty) {
      return const Center(child: Text("No items"));
    } else {
      return ListView.separated(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index].name!),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    }
  }
}
