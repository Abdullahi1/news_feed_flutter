// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorNewsAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NewsAppDatabaseBuilder databaseBuilder(String name) =>
      _$NewsAppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$NewsAppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$NewsAppDatabaseBuilder(null);
}

class _$NewsAppDatabaseBuilder {
  _$NewsAppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$NewsAppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$NewsAppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<NewsAppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$NewsAppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$NewsAppDatabase extends NewsAppDatabase {
  _$NewsAppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NewsDao _newsResponseDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `news_response` (`section` TEXT, `copyright` TEXT, `last_updated` TEXT, `num_results` INTEGER, `results` TEXT, `status` TEXT, PRIMARY KEY (`section`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewsDao get newsResponseDao {
    return _newsResponseDaoInstance ??= _$NewsDao(database, changeListener);
  }
}

class _$NewsDao extends NewsDao {
  _$NewsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _newsResponseInsertionAdapter = InsertionAdapter(
            database,
            'news_response',
            (NewsResponse item) => <String, dynamic>{
                  'section': item.section,
                  'copyright': item.copyright,
                  'last_updated': item.last_updated,
                  'num_results': item.num_results,
                  'results': _resultConverter.encode(item.results),
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NewsResponse> _newsResponseInsertionAdapter;

  @override
  Future<NewsResponse> getNewsResponse(String sectionName) async {
    return _queryAdapter.query('SELECT * FROM news_response WHERE section = ?',
        arguments: <dynamic>[sectionName],
        mapper: (Map<String, dynamic> row) => NewsResponse(
            copyright: row['copyright'] as String,
            last_updated: row['last_updated'] as String,
            num_results: row['num_results'] as int,
            results: _resultConverter.decode(row['results'] as String),
            section: row['section'] as String,
            status: row['status'] as String));
  }

  @override
  Future<void> deleteSection(String sectionName) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM news_response WHERE section = ?',
        arguments: <dynamic>[sectionName]);
  }

  @override
  Future<void> insertNews(NewsResponse newsResponse) async {
    await _newsResponseInsertionAdapter.insert(
        newsResponse, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _resultConverter = ResultConverter();
final _multimediaConverter = MultimediaConverter();
