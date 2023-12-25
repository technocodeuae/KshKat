import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/models/home/category_model.dart';

class CategoryApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CategoryApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<CategoriesListData> getCategory(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.CategoryUrl,
        cancelToken: cancelToken,
        queryParameters: {'limit': limit, 'page': page, 'lang': lang},
      );
      return CategoriesListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<SubCategoryModel> getSubCategory(
      {required CancelToken cancelToken,
      required int cat_id,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.post(
        Endpoints.CategoryDetailUrl,
        cancelToken: cancelToken,
        queryParameters: {'cat_id': cat_id, 'page': page, 'lang': lang},
      );
      final d = SubCategoryModel.fromJson(res);
      print("here sub catgeory response ${d.data!.subs!.length}");
      return SubCategoryModel.fromJson(res);
    } catch (e) {
      print("caught error from get sub category" + e.toString());
      throw e;
    }
  }

  Future<LatestProductListData> getSubCategoryProducts(
      {required CancelToken cancelToken,
      required int cat,
      required int subCat,
      required int page,
      required int? childCat,
      required lang}) async {
    try {
      final res = await _dioClient
          .post(Endpoints.SubChildsProductUrl, //ProductFilterUrl
              cancelToken: cancelToken,
              data: {
            'cat_id': cat,
            'sub_id': subCat,
            'child_id': childCat,
          },
              queryParameters: {
            'page': page,
            'lang': lang
          }
              //  {
              //   'cat': cat,
              //   'subcat': subCat,
              //   'page': page,
              //   'lang': lang
              // },
              );
      print("here${cat} sub$subCat categorychild$childCat product $res");
      return LatestProductListData.fromJson(res);
    } catch (e) {
      print('error ffrom sub category product   ' + e.toString());
      throw e;
    }
  }

  Future<LatestProductListData> getTopProduct(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.TopProductUrl,
        cancelToken: cancelToken,
        queryParameters: {'limit': limit, 'page': page, 'lang': lang},
      );
      return LatestProductListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LatestProductListData> getBestSeller(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.GetBestSellerProductsUrl,
        cancelToken: cancelToken,
        queryParameters: {'limit': limit, 'page': page, 'lang': lang},
      );
      return LatestProductListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LatestProductListData> getPopularProduct(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.GetPopularProductUrl,
        cancelToken: cancelToken,
        queryParameters: {'limit': limit, 'page': page, 'lang': lang},
      );
      return LatestProductListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LatestProductListData> getLatestProduct(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.LatestProductUrl,
        cancelToken: cancelToken,
        queryParameters: {'limit': limit, 'page': page, 'lang': lang},
      );
      return LatestProductListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LatestProductListData> getFlashDeals(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.post(
        Endpoints.FlashDealsUrl,
        cancelToken: cancelToken,
        queryParameters: {'limit': limit, 'page': page, 'lang': lang},
      );
      return LatestProductListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
