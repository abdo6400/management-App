import 'dart:async';
import 'package:baraneq/core/utils/app_strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as p;
import 'dart:io' as io;

class SqlLocalDatabase {
  static const _databaseName = 'baraneq.db';
  static const _databaseVersion = 1;

  // Table names
  static const clientsTable = 'clients';
  static const receiptsTable = 'receipts';
  static const quantitiesTable = 'quantities';
  static const tanksTable = 'tanks';

  // Database instance
  static Database? _database;

  SqlLocalDatabase._privateConstructor();
  static final SqlLocalDatabase instance =
      SqlLocalDatabase._privateConstructor();

  // Initialize and open the database
  Future<Database> _initDatabase() async {
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();
    String dbPath = p.join(appDocumentsDir.path, "databases", _databaseName);
    return openDatabase(dbPath,
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> clearDatabase() async {
    Database db = await instance.database;
    // await db.delete(clientsTable);
    await db.delete(receiptsTable);
    await db.delete(quantitiesTable);
    // await db.delete(tanksTable);
  }

  void checkForeignKeyConstraints() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> receiptsTableInfo =
        await db.rawQuery('PRAGMA foreign_key_list($receiptsTable)');
    List<Map<String, dynamic>> quantitiesTableInfo =
        await db.rawQuery('PRAGMA foreign_key_list($quantitiesTable)');
    print('Receipts Table Foreign Keys: $receiptsTableInfo');
    print('Quantities Table Foreign Keys: $quantitiesTableInfo');
  }

  // Create the database tables
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $clientsTable (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT
      )
    ''');

    await db.execute('''
  CREATE TABLE $receiptsTable (
    id INTEGER PRIMARY KEY,
    clientId INTEGER,
    date TEXT DEFAULT (strftime('%Y-%m-%d', 'now', 'localtime')),
    bont REAL NOT NULL,
    time TEXT NOT NULL DEFAULT 'AM',
    type TEXT NOT NULL,
    FOREIGN KEY (clientId) REFERENCES $clientsTable (id) ON DELETE CASCADE
  )
''');
    /*   await db.execute('''
      CREATE TRIGGER IF NOT EXISTS set_time
      BEFORE INSERT ON $receiptsTable
      FOR EACH ROW
      BEGIN
        UPDATE receipts
        SET time = CASE
          WHEN strftime('%H', 'now', 'localtime') < '12' THEN 'AM'
          ELSE 'PM'
        END
        WHERE id = NEW.id;
      END;
    ''');

    await db.execute('''
      CREATE TRIGGER IF NOT EXISTS set_time_update
      BEFORE UPDATE ON $receiptsTable
      FOR EACH ROW
      BEGIN
        UPDATE receipts
        SET time = CASE
          WHEN strftime('%H', 'now', 'localtime') < '12' THEN 'AM'
          ELSE 'PM'
        END
        WHERE id = NEW.id;
      END;
    ''');*/
    await db.execute('''
      CREATE TABLE $quantitiesTable (
        id INTEGER PRIMARY KEY,
        quantityValue REAL NOT NULL,
        receiptId INTEGER,
        tankId INTEGER,
        FOREIGN KEY (receiptId) REFERENCES $receiptsTable (id) ON DELETE CASCADE,
        FOREIGN KEY (tankId) REFERENCES $tanksTable (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE $tanksTable (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        capacity REAL NOT NULL
      )
    ''');
  }

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Insert a new client
  Future<int> insertClient(Map<String, dynamic> client) async {
    Database db = await instance.database;
    return await db.insert(clientsTable, client);
  }

  // Retrieve all clients
  Future<List<Map<String, dynamic>>> getClients() async {
    Database db = await instance.database;
    return await db.query(clientsTable);
  }

  // Update a client
  Future<int> updateClient(Map<String, dynamic> client) async {
    Database db = await instance.database;
    int id = client['id'];
    return await db
        .update(clientsTable, client, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a client
  Future<int> deleteClient(int id) async {
    Database db = await instance.database;
    return await db.delete(clientsTable, where: 'id = ?', whereArgs: [id]);
  }

  // Insert a new quantity
  Future<int> insertQuantity(Map<String, dynamic> quantity) async {
    Database db = await instance.database;
    return await db.insert(quantitiesTable, quantity);
  } // Retrieve all quantities

  Future<List<Map<String, dynamic>>> getQuantities() async {
    Database db = await instance.database;
    return await db.query(quantitiesTable);
  }

  // Delete a quantity
  Future<int> deleteQuantity(int id) async {
    Database db = await instance.database;
    return await db.delete(quantitiesTable, where: 'id = ?', whereArgs: [id]);
  }

  // Insert a new receipt
  Future<int> insertReceipt(Map<String, dynamic> receipt) async {
    Database db = await instance.database;

    return await db.insert(receiptsTable, receipt);
  }

  // Retrieve all receipts
  Future<List<Map<String, dynamic>>> getReceipts() async {
    Database db = await instance.database;
    return await db.query(receiptsTable);
  }

  // Update a receipt
  Future<int> updateReceipt(Map<String, dynamic> receipt) async {
    Database db = await instance.database;
    int id = receipt['id'];
    return await db
        .update(receiptsTable, receipt, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a receipt
  Future<int> deleteReceipt(int id) async {
    Database db = await instance.database;

    return await db.delete(receiptsTable, where: 'id = ?', whereArgs: [id]);
  }

  // Insert a new tank
  Future<int> insertTank(Map<String, dynamic> tank) async {
    Database db = await instance.database;
    return await db.insert(tanksTable, tank);
  }

  // Retrieve all tanks
  Future<List<Map<String, dynamic>>> getTanks() async {
    Database db = await instance.database;
    return await db.query(tanksTable);
  }

  // Update a tank
  Future<int> updateTank(Map<String, dynamic> tank) async {
    Database db = await instance.database;
    int id = tank['id'];
    return await db.update(tanksTable, tank, where: 'id = ?', whereArgs: [id]);
  }

  // Delete a tank
  Future<int> deleteTank(int id) async {
    Database db = await instance.database;
    return await db.delete(tanksTable, where: 'id = ?', whereArgs: [id]);
  }

  // Get clients registered on a specific date
  // Get daily clients with pagination
  Future<List<Map<String, dynamic>>> getDailyClients(
      {required Map<String, dynamic> options}) async {
    Database db = await instance.database;
    String formattedDate = _formatDateTime(DateTime.now());
    int offset = (options['page'] - 1) * options['pageSize'];

    String typeCondition = "";
    if (options['type'] != null &&
        (options['type'] == AppStrings.importer.toUpperCase() ||
            options['type'] == AppStrings.exporter.toUpperCase())) {
      typeCondition = "AND r.type = '${options['type']}'";
    }

    return await db.rawQuery('''
    SELECT 
      c.id AS clientId, 
      c.name AS clientName, 
      c.phone AS clientPhone,
      '[' || GROUP_CONCAT(
          '{' ||
          '"receiptId": ' || r.id || ', ' ||
          '"receiptDate": "' || r.date || '", ' ||
          '"receiptType": "' || r.type || '", ' ||
          '"receiptTime": "' || r.time || '", ' ||
          '"bont": "' || r.bont || '", ' ||
          '"totalQuantity": ' || r.totalQuantity ||
          '}'
      ) || ']' AS receipts
    FROM 
      $clientsTable c
    JOIN (
      SELECT 
          r.id, 
          r.clientId, 
          r.date, 
          r.type, 
          r.bont,
          r.time, 
          SUM(q.quantityValue) AS totalQuantity
      FROM 
          $receiptsTable r
      LEFT JOIN 
          $quantitiesTable q ON r.id = q.receiptId
      WHERE r.date = '$formattedDate' $typeCondition
      GROUP BY 
          r.id, r.clientId, r.date, r.type, r.time
    ) r ON c.id = r.clientId
    GROUP BY 
      c.id, c.name, c.phone
    LIMIT ${options['pageSize']} OFFSET $offset;
  ''');
  }

// Search clients with filters (date range and name) and pagination
  Future<List<Map<String, dynamic>>> searchWithFilters({
    required Map<String, dynamic> filters,
  }) async {
    Database db = await instance.database;
    DateTime? fromDate = filters["fromDate"];
    DateTime? toDate = filters["toDate"];
    int? idFilter = filters["id"];
    String? typeFilter = filters["type"];
    int offset = (filters['page'] - 1) * filters['pageSize'];

    String dateCondition = '';
    if (fromDate != null && toDate != null) {
      String formattedFromDate = _formatDateTime(fromDate);
      String formattedToDate = _formatDateTime(
          toDate.add(Duration(days: 1))); // Add one day to include end date
      dateCondition =
          'AND r.date BETWEEN \'$formattedFromDate\' AND \'$formattedToDate\'';
    }

    String idCondition = '';
    if (idFilter != null) {
      idCondition = 'AND c.id = $idFilter';
    }

    String typeCondition = '';
    if (typeFilter != null) {
      if (typeFilter == AppStrings.importer.toUpperCase()) {
        typeCondition = 'AND r.type = \'IMPORTER\'';
      } else if (typeFilter == AppStrings.exporter.toUpperCase()) {
        typeCondition = 'AND r.type = \'EXPORTER\'';
      }
    }

    String query = '''
  SELECT 
      c.id AS clientId, 
      c.name AS clientName, 
      c.phone AS clientPhone,
     COALESCE( '[' || GROUP_CONCAT(
          '{' ||
          '"receiptDate": "' || r.date || '", ' ||
          '"totalQuantityForAM": ' || COALESCE(r.totalQuantityForAM, 0) || ', ' ||
          '"biggestBontForAM": ' || COALESCE(r.biggestBontForAM, 0) || ', ' ||
          '"totalQuantityForPM": ' || COALESCE(r.totalQuantityForPM, 0) || ', ' ||
          '"biggestBontForPM": ' || COALESCE(r.biggestBontForPM, 0) || ', ' ||
          '"totalQuantityForDay": ' || COALESCE(r.totalQuantityForDay, 0) || ', ' ||
          '"totalImportedQuantity": ' || COALESCE(r.totalImportedQuantity, 0) || ', ' ||
          '"totalExportedQuantity": ' || COALESCE(r.totalExportedQuantity, 0) ||
          '}' 
      ) || ']' , '[]') AS receipts
  FROM 
      clients c
  LEFT JOIN (
      SELECT 
          r.clientId, 
          r.date, 
          SUM(CASE WHEN r.time = 'AM' THEN q.quantityValue ELSE 0 END) AS totalQuantityForAM,
          MAX(CASE WHEN r.time = 'AM' THEN r.bont ELSE 0 END) AS biggestBontForAM,
          SUM(CASE WHEN r.time = 'PM' THEN q.quantityValue ELSE 0 END) AS totalQuantityForPM,
          MAX(CASE WHEN r.time = 'PM' THEN r.bont ELSE 0 END) AS biggestBontForPM,
          SUM(CASE WHEN r.type = 'IMPORTER' THEN q.quantityValue ELSE 0 END) AS totalImportedQuantity,
          SUM(CASE WHEN r.type = 'EXPORTER' THEN q.quantityValue ELSE 0 END) AS totalExportedQuantity,
          SUM(q.quantityValue) AS totalQuantityForDay
      FROM 
          receipts r
      LEFT JOIN 
          quantities q ON r.id = q.receiptId
      WHERE 1=1 $dateCondition $typeCondition
      GROUP BY 
          r.clientId, r.date
  ) r ON c.id = r.clientId
  WHERE 1=1 $idCondition
  GROUP BY 
      c.id, c.name, c.phone
  LIMIT ${filters['pageSize']} OFFSET $offset;
  ''';

    List<Map<String, dynamic>> results = await db.rawQuery(query);

    return results;
  }

  Future<List<Map<String, dynamic>>> searchWithNameAboutClient({
    required Map<String, dynamic> filters,
  }) async {
    // Get a reference to the database.
    Database db = await instance.database;

    // Prepare the base query
    String query = 'SELECT * FROM clients WHERE 1=1';
    List<dynamic> arguments = [];

    // Add name filter to the query
    if (filters.containsKey('name') && filters['name'].isNotEmpty) {
      query += ' AND name LIKE ?';
      arguments.add('%${filters['name']}%');
    }

    // Add limit filter to the query
    if (filters.containsKey('limit') && filters['limit'] is int) {
      query += ' LIMIT ?';
      arguments.add(filters['limit']);
    }

    // Execute the query
    final List<Map<String, dynamic>> results =
        await db.rawQuery(query, arguments);

    return results;
  }

// Get clients registered within a date range with pagination
  Future<List<Map<String, dynamic>>> getClientsWithinDates({
    required Map<String, dynamic> filters,
  }) async {
    Database db = await instance.database;
    DateTime fromDate = filters["fromDate"];
    DateTime toDate = filters["toDate"];
    String formattedFromDate = _formatDateTime(fromDate);
    String formattedToDate = _formatDateTime(toDate.add(Duration(days: 1)));
    int offset = (filters['page'] - 1) * filters['pageSize'];

    List<Map<String, dynamic>> clientsWithReceipts = await db.rawQuery('''
    SELECT 
      c.id AS clientId, 
      c.name AS clientName, 
      c.phone AS clientPhone,
      '[' || GROUP_CONCAT(
          '{' ||
          '"receiptId": ' || r.id || ', ' ||
          '"receiptDate": "' || r.date || '", ' ||
          '"receiptType": "' || r.type || '", ' ||
          '"receiptTime": "' || r.time || '", ' ||
          '"bont": "' || r.bont || '", ' ||
          '"totalQuantity": ' || r.totalQuantity ||
          '}'
      ) || ']' AS receipts
    FROM 
      $clientsTable c
    JOIN (
      SELECT 
          r.id, 
          r.clientId, 
          r.date, 
          r.type, 
          r.bont,
          r.time, 
          SUM(q.quantityValue) AS totalQuantity
      FROM 
          $receiptsTable r
      LEFT JOIN 
          $quantitiesTable q ON r.id = q.receiptId
      WHERE 
          r.date BETWEEN '$formattedFromDate' AND '$formattedToDate'
      GROUP BY 
          r.id, r.clientId, r.date, r.type, r.time
    ) r ON c.id = r.clientId
    GROUP BY 
      c.id, c.name, c.phone
    LIMIT ${filters['pageSize']} OFFSET $offset;
  ''');

    return clientsWithReceipts;
  }

// Get tanks with quantities with pagination (if needed)
  Future<List<Map<String, dynamic>>> getTanksWithQuantities(
      {required Map<String, dynamic> options}) async {
    Database db = await instance.database;
    int offset = (options['page'] - 1) * options['pageSize'];

    return await db.rawQuery('''
  SELECT 
    t.id AS tankId, 
    t.name AS tankName,
    t.capacity AS tankCapacity,
    (SELECT 
        COALESCE(SUM(
            CASE 
                WHEN r.type = 'IMPORTER' THEN q.quantityValue 
                WHEN r.type = 'EXPORTER' THEN -q.quantityValue 
                ELSE 0 
            END
        ), 0)
    FROM $quantitiesTable q
    JOIN $receiptsTable r ON q.receiptId = r.id
    WHERE q.tankId = t.id) AS totalQuantity
  FROM $tanksTable t
  LIMIT ${options['pageSize']} OFFSET $offset;
  ''');
  }

// Get clients with receipts count and pagination
  Future<List<Map<String, dynamic>>> getClientsWithReceiptsCount(
      {required Map<String, dynamic> options}) async {
    Database db = await instance.database;
    int offset = (options['page'] - 1) * options['pageSize'];

    return await db.rawQuery('''
    WITH ClientCounts AS (
      SELECT 
        COUNT(*) AS totalClientsCount
      FROM 
        $clientsTable
    ),
    ReceiptDetails AS (
      SELECT 
        c.id AS id, 
        c.name AS name, 
        c.phone AS phone,
        COUNT(DISTINCT r.id) AS receiptsCount,
        COALESCE(SUM(CASE WHEN r.type = '${AppStrings.importer.toUpperCase()}' THEN q.quantityValue ELSE 0 END), 0) AS importerReceiptsTotalQuantity,
        COALESCE(SUM(CASE WHEN r.type = '${AppStrings.exporter.toUpperCase()}' THEN q.quantityValue ELSE 0 END), 0) AS exporterReceiptsTotalQuantity
      FROM 
        $clientsTable c
      LEFT JOIN 
        $receiptsTable r ON c.id = r.clientId
      LEFT JOIN 
        $quantitiesTable q ON r.id = q.receiptId
      GROUP BY 
        c.id, c.name, c.phone
      LIMIT ${options['pageSize']} OFFSET $offset
    )
    SELECT
      ClientCounts.totalClientsCount,
      ReceiptDetails.*
    FROM
      ClientCounts,
      ReceiptDetails;
  ''');
  }

  // Get balance based on receipts and quantities
  Future<Map<String, dynamic>> getBalance() async {
    Database db = await instance.database;

    // Fetch all receipts with their type
    List<Map<String, dynamic>> receipts = await db.query(
      receiptsTable,
      columns: ['id', 'type'],
    );

    double totalBalance = 0.0;
    double totalExporterBalance = 0.0;
    double totalImporterBalance = 0.0;
    // Iterate through each receipt to calculate balance
    for (var receipt in receipts) {
      // Fetch quantities associated with the current receipt
      List<Map<String, dynamic>> quantities = await db.query(
        quantitiesTable,
        where: 'receiptId = ?',
        whereArgs: [receipt['id']],
      );

      // Calculate total quantity for the receipt
      double totalQuantity = quantities.isNotEmpty
          ? quantities
              .map<double>((q) => q['quantityValue'] as double)
              .reduce((a, b) => a + b)
          : 0.0;

      // Determine whether to add or subtract based on receipt type
      if (receipt['type'] == AppStrings.importer.toUpperCase()) {
        totalBalance += totalQuantity;
        totalImporterBalance += totalQuantity;
      } else if (receipt['type'] == AppStrings.exporter.toUpperCase()) {
        totalBalance -= totalQuantity;
        totalExporterBalance += totalQuantity;
      }
    }

    return {
      AppStrings.balance: totalBalance,
      AppStrings.importer: totalImporterBalance,
      AppStrings.exporter: totalExporterBalance,
      AppStrings.clientsNumber: (await _getClientsNumber())['count']
    };
  }

  Future<Map<String, dynamic>> _getClientsNumber() async {
    Database db = await instance.database;

    return (await db
            .rawQuery('''SELECT COUNT(*) As count  FROM $clientsTable'''))
        .first;
  }

  // Helper function to format DateTime to SQLite compatible format
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
  }
}
