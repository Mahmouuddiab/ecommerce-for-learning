import 'package:dio/dio.dart';
import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/core/params/address_params.dart';
import 'package:ecommerce/features/adresses/data/model/address_model.dart';
import 'package:ecommerce/features/adresses/data/model/saved_address_model.dart';

abstract class AddressRemoteDs {
  Future<AddressModel> addAddress(AddressParams params);
  Future<List<SavedAddressModel>> getSavedAddress();
  Future<SavedAddressModel> deleteAddress(String id);
}

class AddressRemoteDsImpl implements AddressRemoteDs {
  @override
  Future<AddressModel> addAddress(AddressParams params) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.addAddress,
        withAuth: true,
        data: {
          "name": params.name,
          "details": params.details,
          "phone": params.phone,
          "city": params.city,
        },
      );

      if (response.statusCode == 200) {
        return AddressModel.fromJson(response.data);
      }

      throw ServerException();
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? e.message ?? 'Server Error',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<SavedAddressModel>> getSavedAddress() async {
    try {
      final response = await DioHelper.get(
        path: ApiConstants.getSavedAddress,
        withAuth: true,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List data = responseData['data'] as List;
        return data.map((e) => SavedAddressModel.fromJson(e)).toList();
      } else {
        throw ServerException(
          'Failed to fetch addresses. Status: ${response.statusCode}',
        );
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SavedAddressModel> deleteAddress(String id) async {
    try {
      final response = await DioHelper.delete(
        path: ApiConstants.deleteAddress(id),
        withAuth: true,
      );
      if (response.statusCode == 200) {
        return SavedAddressModel.fromJson(response.data);
      } else {
        throw ServerException('something went wrong');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
