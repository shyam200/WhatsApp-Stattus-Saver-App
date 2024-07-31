import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'isar_adapters_provider.dart';

class IsarDBWrapper {
  final IsarAdaptersProvider isarAdaptersProvider;
  late Isar? _isar;
  final String _dbKey = "dbKey";

  IsarDBWrapper({required this.isarAdaptersProvider});

  Future<IsarDBWrapper> init() async {
    //initializing the DB
    try {
      _isar = await _getIsarObject();
    } catch (_) {
      try {
        _isar = await _getIsarObject();
      } catch (_) {
        _isar = null;
      }
    }
    return this;
  }

  Future<Isar?> _getIsarObject() async {
    Isar? isar = Isar.getInstance();
    try {
      if (isar == null) {
        final dir = await _getDir();
        isar =
            await Isar.open(isarAdaptersProvider.getAdapters(), directory: dir);
        log("isar= $isar");
      }
    } catch (e) {
      log("isar ex= $e");
    }

    return isar;
  }

  Future<String> _getDir() async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<void> addObject<T>({dynamic dataObject}) async {
    try {
      await _isar?.writeTxn(() async {
        await _isar?.collection<T>().put(dataObject);
      });
    } catch (e) {
      log("exception:- $e");
    }
  }

  Future<dynamic> getObject<T>({String? dbKey}) async {
    try {
      final result = _isar?.collection<T>();
      final String dbValueKey = dbKey ?? T.toString();
      final dataList = await result?.buildQuery(whereClauses: [
        IndexWhereClause.equalTo(
          indexName: _dbKey,
          value: [dbValueKey],
        )
      ]).findAll();
      if (dataList?.isEmpty ?? true) {
        return null;
      }
      return dataList?.first;
    } catch (_) {}
  }

  Future<void> deleteObject<T>({String? dbKey}) async {
    try {
      final dbValueKey = dbKey ?? T.toString();
      final result = _isar?.collection<T>();
      await _isar?.writeTxn(() async {
        result?.buildQuery(whereClauses: [
          IndexWhereClause.equalTo(
            indexName: _dbKey,
            value: [dbValueKey],
          )
        ]).deleteAll();
      });
    } catch (_) {}
  }

  Future<void> deleteDB() async {
    try {
      await _isar?.writeTxn(() async {
        _isar?.clear();
      });
    } catch (_) {}
  }
}
