import 'package:bloc_login/bloc_layer/bloc_cubit/auth_cubit.dart';
import 'package:bloc_login/bloc_layer/bloc_traditional/category_bloc.dart';
import 'package:bloc_login/bloc_layer/bloc_traditional/category_state.dart';
import 'package:bloc_login/data_layer/provider/api.dart';
import 'package:bloc_login/data_layer/repositories/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'locator.dart';

class ProviderInjector {
  static List<SingleChildWidget> providers = [
    ..._independentServices,
    ..._dependentServices,
    ..._consumableServices,
  ];

  static final List<SingleChildWidget> _independentServices = [
    Provider.value(value: locator<Api>()),
    Provider.value(value: locator<SharedPreferences>()),
  ];

  static final List<SingleChildWidget> _dependentServices = [
    ProxyProvider<Api, AuthenticationService>(
        update: (context, api, authenticationService) =>
            AuthenticationService(api: api)),
  ];

  static final List<SingleChildWidget> _consumableServices = [
    BlocProvider(create: (_) => AuthCubit()),
    BlocProvider(create: (_) => CategoryBloc(CategoryStateDefault()))
  ];
}
