import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class DataCubit extends Cubit<Map<String, dynamic>?> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  final String _storageKey = "userData";

  DataCubit() : super(null) {
    _loadData();
  }

  Future<void> _loadData() async {
    String? storedData = await _storage.read(key: _storageKey);
    if (storedData != null) {
      emit(jsonDecode(storedData));
    }else{
      emit(null);
    }
  }

  //signout
  Future<void> signout() async {
    await _storage.delete(key: _storageKey);
    emit(null);
  }

  /// Update data and save globally
  Future<void> updateData(Map<String, dynamic> newData) async {
    await _storage.write(
        key: _storageKey, value: jsonEncode(newData));
    _loadData();
  }
}
