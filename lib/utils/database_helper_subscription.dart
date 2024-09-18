import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:subscribe_manager/Models/subscription.dart';

class DatabaseHelperSubscription {
  static DatabaseHelperSubscription? _databaseHelper;
  static Database? _database;

  factory DatabaseHelperSubscription() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelperSubscription._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DatabaseHelperSubscription._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "subscription.db");
    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "subscription.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    return await openDatabase(path, readOnly: false);
  }

  Future<List<Map<String, dynamic>>> getSubscription() async {
    var db = await _getDatabase();
    var sonuc = await db.query("subscription", orderBy: "ID DESC");

    return sonuc;
  }

  // Future<List<Map<String, dynamic>>> getFavoritesHistory() async {
  //   var db = await _getDatabase();
  //   var sonuc =
  //       await db.rawQuery('SELECT * FROM history WHERE is_favorite = 1');

  //   return sonuc;
  // }

  // Future<List<Map<String, dynamic>>> getNoFolderHistory() async {
  //   var db = await _getDatabase();
  //   var sonuc = await db.rawQuery(
  //       "SELECT * FROM history WHERE folder_ID = '0'  ORDER BY is_favorite DESC, created_At DESC");

  //   return sonuc;
  // }

  // Future<List<Map<String, dynamic>>> getHistoryWithFolderID(
  //     int folder_ID) async {
  //   var db = await _getDatabase();
  //   var sonuc = await db.rawQuery(
  //       "SELECT * FROM history WHERE folder_ID = ? ORDER BY is_favorite DESC, created_At DESC",
  //       [folder_ID]);

  //   return sonuc;
  // }

  Future<List<Subscription>> getSubscriptionList() async {
    var mapListSubscription = await getSubscription();
    var subscriptionList = <Subscription>[];
    for (Map<String, dynamic> map in mapListSubscription) {
      subscriptionList.add(Subscription.fromMap(map));
    }
    return subscriptionList;
  }

  Future<List<Subscription>> getSubscriptionListByPlatform(
      String platformName) async {
    var db = await _getDatabase();
    var result = await db.query('subscription',
        where: 'platform_Name = ?', whereArgs: [platformName]);

    // SQLite sorgusundan gelen sonuçları Subscription nesnelerine dönüştürmek
    List<Subscription> subscriptionList = [];
    for (Map<String, dynamic> row in result) {
      subscriptionList.add(Subscription.fromMap(row));
    }
    return subscriptionList;
  }

  Future<bool> checkSubscriptionExists(String platformName) async {
    final subscriptions =
        await DatabaseHelperSubscription().getSubscriptionList();
    for (var subscription in subscriptions) {
      if (subscription.platform_Name == platformName) {
        return true;
      }
    }
    return false;
  }

  // Future<List<History>> getFavoritesHistoryList() async {
  //   var mapListHistory = await getFavoritesHistory();
  //   var historyList = <History>[];
  //   for (Map<String, dynamic> map in mapListHistory) {
  //     historyList.add(History.fromMap(map));
  //   }
  //   return historyList;
  // }

  // Future<List<History>> getHistoryListWithNoFolder() async {
  //   var mapListHistory = await getNoFolderHistory();
  //   var historyList = <History>[];
  //   for (Map<String, dynamic> map in mapListHistory) {
  //     historyList.add(History.fromMap(map));
  //   }
  //   return historyList;
  // }

  // Future<List<History>> getHistoryListWithFolderID(int folder_ID) async {
  //   var mapListHistory = await getHistoryWithFolderID(folder_ID);
  //   var historyList = <History>[];
  //   for (Map<String, dynamic> map in mapListHistory) {
  //     historyList.add(History.fromMap(map));
  //   }
  //   return historyList;
  // }

  Future<int> addSubscription(Subscription subscription) async {
    var db = await _getDatabase();
    var sonuc = db.insert('subscription', subscription.toMap());
    return sonuc;
  }

  Future<int> deleteSubscription(String platfromName) async {
    var db = await _getDatabase();
    var sonuc = db.delete('subscription',
        where: 'platform_Name=?', whereArgs: [platfromName]);
    return sonuc;
  }

  // Future<int> updateFavorite(int historyID, bool isFavorite) async {
  //   var db = await _getDatabase();
  //   var sonuc = db.update('history', {'is_favorite': isFavorite ? 1 : 0},
  //       where: 'ID=?', whereArgs: [historyID]);
  //   return sonuc;
  // }

  // Future<int> updateFolder(int historyID, int folder_ID) async {
  //   var db = await _getDatabase();
  //   var sonuc = db.update('history', {'folder_ID': folder_ID},
  //       where: 'ID=?', whereArgs: [historyID]);
  //   return sonuc;
  // }

  Future<int> updateSubscriptionStartDate(
      int subscriptionID, String start_Date) async {
    var db = await _getDatabase();
    var sonuc = db.update('subscription', {'start_Date': start_Date},
        where: 'ID=?', whereArgs: [subscriptionID]);
    return sonuc;
  }

  Future<int> updateSubscriptionEndDate(
      int subscriptionID, String end_Date) async {
    var db = await _getDatabase();
    var sonuc = db.update('subscription', {'end_Date': end_Date},
        where: 'ID=?', whereArgs: [subscriptionID]);
    return sonuc;
  }

  // Future<int> updateHistoryKeyword(int historyID, String keyword) async {
  //   var db = await _getDatabase();
  //   var sonuc = db.update('history', {'keyword': keyword},
  //       where: 'ID=?', whereArgs: [historyID]);
  //   return sonuc;
  // }

  // Future<int> updateHistoryUsecase(int historyID, String usecase) async {
  //   var db = await _getDatabase();
  //   var sonuc = db.update('history', {'usecase': usecase},
  //       where: 'ID=?', whereArgs: [historyID]);
  //   return sonuc;
  // }

  // Future<int> updateFolderWhenFolderDelete(int folder_ID) async {
  //   var db = await _getDatabase();
  //   var sonuc = db.update('history', {'folder_ID': 0},
  //       where: 'folder_ID=?', whereArgs: [folder_ID]);
  //   return sonuc;
  // }
}
