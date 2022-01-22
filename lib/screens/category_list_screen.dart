import 'package:bloc_login/bloc_rxdart/get_categories_bloc.dart';
import 'package:bloc_login/models/category.dart';
import 'package:bloc_login/models/category_response.dart';
import 'package:flutter/material.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    categoriesBloc.getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<CategoryResponse>(
          stream: categoriesBloc.subject.stream,
          builder: (context, AsyncSnapshot<CategoryResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error.isNotEmpty) {
                return _buildErrorWidget(snapshot.data!.error);
              } else {
                return _buildListCategory(snapshot.data!);
              }
            } else if (snapshot.hasError) {
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
