// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'authentication/authentication_service.dart' as _i3;
import 'post/post.dart' as _i7;
import 'post/post_service.dart' as _i12;
import 'presentation/add_post_page/bloc/add_post_page_bloc.dart' as _i11;
import 'presentation/edit_profile_page/bloc/edit_profile_page_bloc.dart' as _i5;
import 'presentation/home_page/bloc/home_page_bloc.dart' as _i6;
import 'presentation/profile_page/bloc/profile_page_bloc.dart' as _i8;
import 'presentation/sign_in_page/bloc/sign_in_page_bloc.dart' as _i9;
import 'presentation/sign_up_page/bloc/sign_up_page_bloc.dart' as _i10;
import 'profile/profile.dart' as _i4;
import 'profile/profile_service.dart' as _i13;
import 'shared_kernel/domain/model/username.dart' as _i15;
import 'shared_kernel/domain/service/username_specification.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthenticationService>(
      () => _i3.AuthenticationService(get<_i4.ProfileService>()));
  gh.factory<_i5.EditProfilePageBloc>(() => _i5.EditProfilePageBloc(
      get<_i3.AuthenticationService>(), get<_i4.ProfileService>()));
  gh.factory<_i6.HomePageBloc>(() => _i6.HomePageBloc(
      get<_i3.AuthenticationService>(), get<_i7.PostService>()));
  gh.factory<_i8.ProfilePageBloc>(() => _i8.ProfilePageBloc(
      get<_i3.AuthenticationService>(),
      get<_i4.ProfileService>(),
      get<_i7.PostService>()));
  gh.factory<_i9.SignInPageBloc>(
      () => _i9.SignInPageBloc(get<_i3.AuthenticationService>()));
  gh.factory<_i10.SignUpPageBloc>(
      () => _i10.SignUpPageBloc(get<_i3.AuthenticationService>()));
  gh.factory<_i11.AddPostPageBloc>(() => _i11.AddPostPageBloc(
      get<_i3.AuthenticationService>(), get<_i7.PostService>()));
  gh.singleton<_i13.ProfileService>(_i13.ProfileService());
  gh.singleton<_i12.PostService>(_i12.PostService(get<_i4.ProfileService>()));
  gh.singleton<_i14.UsernameSpecification>(_i14.UsernameSpecification());
  gh.singleton<_i15.UsernameFactory>(
      _i15.UsernameFactory(get<_i14.UsernameSpecification>()));
  return get;
}
