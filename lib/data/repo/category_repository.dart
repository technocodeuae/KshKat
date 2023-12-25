import 'dart:async';

import 'package:erp/data/network/apis/home/category_api.dart';
import 'package:erp/models/home/category_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class CategoryRepository {

  // api objects
  final CategoryApi _medicineApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  CategoryRepository(this._medicineApi, this._sharedPrefsHelper);

  /// medicine EndPoints: ---------------------------------------------------------------------

  Future<CategoriesListData> getCategory(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getCategory(cancelToken: cancelToken,limit:limit,page:page,lang: lang);
    return _info;
  }

  Future<SubCategoryModel> getSubCategory(
      {required CancelToken cancelToken,
        required int cat_id,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getSubCategory(cancelToken: cancelToken,cat_id:cat_id,page:page,lang: lang);
    return _info;
  }

  Future<LatestProductListData> getSubCategoryProducts(
      {required CancelToken cancelToken,
        required int cat,
        required int subCat,
        required int page,
        required lang,
        required int? childCat,
      }) async {
    var _info =
    await _medicineApi.getSubCategoryProducts(cancelToken: cancelToken,cat:cat,subCat: subCat,page:page,lang: lang, childCat:childCat);
    return _info;
  }


  Future<LatestProductListData> getTopProduct(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getTopProduct(cancelToken: cancelToken,limit:limit,page:page,lang: lang);
    return _info;
  }

   Future<LatestProductListData> getBestSeller(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getBestSeller(cancelToken: cancelToken,limit:limit,page:page,lang: lang);
    return _info;
  }

  
   Future<LatestProductListData> getPopularProduct(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getPopularProduct(cancelToken: cancelToken,limit:limit,page:page,lang: lang);
    return _info;
  }


  Future<LatestProductListData> getLatestProduct(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getLatestProduct(cancelToken: cancelToken,limit:limit,page:page,lang: lang);
    return _info;
  }

  Future<LatestProductListData> getFlashDeals(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    var _info =
    await _medicineApi.getFlashDeals(cancelToken: cancelToken,limit:limit,page:page,lang: lang);
    return _info;
  }

}
