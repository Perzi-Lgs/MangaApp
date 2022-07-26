// Mocks generated by Mockito 5.1.0 from annotations
// in mobile/test/homepage/data/repositories/Homepage_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mobile/features/homepage/data/model/Manga_info_model.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

import 'Homepage_repository_impl_test.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [THomepageRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTHomepageRemoteDataSource extends _i1.Mock
    implements _i2.THomepageRemoteDataSource {
  MockTHomepageRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MangaInfoModel>> getListMangaInfoPerSource(
          String? source) =>
      (super.noSuchMethod(
          Invocation.method(#getListMangaInfoPerSource, [source]),
          returnValue: Future<List<_i4.MangaInfoModel>>.value(
              <_i4.MangaInfoModel>[])) as _i3.Future<List<_i4.MangaInfoModel>>);
  @override
  _i3.Future<List<_i4.MangaInfoModel>> getHomepageScans(
          String? route, int? page) =>
      (super.noSuchMethod(Invocation.method(#getHomepageScans, [route, page]),
          returnValue: Future<List<_i4.MangaInfoModel>>.value(
              <_i4.MangaInfoModel>[])) as _i3.Future<List<_i4.MangaInfoModel>>);
}

/// A class which mocks [TNetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockTNetworkInfo extends _i1.Mock implements _i2.TNetworkInfo {
  MockTNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}
