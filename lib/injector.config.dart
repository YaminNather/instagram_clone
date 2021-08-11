// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'authentication/authentication_service.dart' as _i3;
import 'follow/follow_service.dart' as _i6;
import 'post/likes_service.dart' as _i9;
import 'post/post.dart' as _i8;
import 'post/post_service.dart' as _i10;
import 'presentation/add_post_page/bloc/add_post_page_bloc.dart' as _i14;
import 'presentation/edit_profile_page/bloc/edit_profile_page_bloc.dart' as _i5;
import 'presentation/home_page/bloc/home_page_bloc.dart' as _i7;
import 'presentation/profile_page/bloc/profile_page_bloc.dart' as _i11;
import 'presentation/sign_in_page/bloc/sign_in_page_bloc.dart' as _i12;
import 'presentation/sign_up_page/bloc/sign_up_page_bloc.dart' as _i13;
import 'profile/profile.dart' as _i4;
import 'profile/profile_service.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthenticationService>(
      () => _i3.AuthenticationService(get<_i4.ProfileService>()));
  gh.factory<_i5.EditProfilePageBloc>(() => _i5.EditProfilePageBloc(
      get<_i3.AuthenticationService>(), get<_i4.ProfileService>()));
  gh.factory<_i6.FollowService>(() => _i6.FollowService());
  gh.factory<_i7.HomePageBloc>(() => _i7.HomePageBloc(
      get<_i3.AuthenticationService>(), get<_i8.PostService>()));
  gh.lazySingleton<_i9.LikesService>(() => _i9.LikesService());
  gh.lazySingleton<_i10.PostService>(
      () => _i10.PostService(get<_i4.ProfileService>()));
  gh.factory<_i11.ProfilePageBloc>(() => _i11.ProfilePageBloc(
      get<_i3.AuthenticationService>(),
      get<_i4.ProfileService>(),
      get<_i8.PostService>(),
      get<_i6.FollowService>()));
  gh.factory<_i12.SignInPageBloc>(
      () => _i12.SignInPageBloc(get<_i3.AuthenticationService>()));
  gh.factory<_i13.SignUpPageBloc>(
      () => _i13.SignUpPageBloc(get<_i3.AuthenticationService>()));
  gh.factory<_i14.AddPostPageBloc>(() => _i14.AddPostPageBloc(
      get<_i3.AuthenticationService>(), get<_i8.PostService>()));
  gh.singleton<_i15.ProfileService>(_i15.ProfileService());
  return get;
}
