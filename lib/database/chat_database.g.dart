// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorChatDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ChatDatabaseBuilder databaseBuilder(String name) =>
      _$ChatDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ChatDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ChatDatabaseBuilder(null);
}

class _$ChatDatabaseBuilder {
  _$ChatDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ChatDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ChatDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ChatDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ChatDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ChatDatabase extends ChatDatabase {
  _$ChatDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MessageDao? _messageDaoInstance;

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `messages` (`primaryKey` INTEGER PRIMARY KEY AUTOINCREMENT, `content` TEXT NOT NULL, `author` TEXT NOT NULL, `timestamp` TEXT NOT NULL, `recipientClientId` TEXT NOT NULL, `isUnread` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`clientId` TEXT NOT NULL, `username` TEXT NOT NULL, PRIMARY KEY (`clientId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MessageDao get messageDao {
    return _messageDaoInstance ??= _$MessageDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$MessageDao extends MessageDao {
  _$MessageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _databaseMessageInsertionAdapter = InsertionAdapter(
            database,
            'messages',
            (DatabaseMessage item) => <String, Object?>{
                  'primaryKey': item.primaryKey,
                  'content': item.content,
                  'author': item.author,
                  'timestamp': item.timestamp,
                  'recipientClientId': item.recipientClientId,
                  'isUnread': item.isUnread ? 1 : 0
                }),
        _databaseMessageDeletionAdapter = DeletionAdapter(
            database,
            'messages',
            ['primaryKey'],
            (DatabaseMessage item) => <String, Object?>{
                  'primaryKey': item.primaryKey,
                  'content': item.content,
                  'author': item.author,
                  'timestamp': item.timestamp,
                  'recipientClientId': item.recipientClientId,
                  'isUnread': item.isUnread ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DatabaseMessage> _databaseMessageInsertionAdapter;

  final DeletionAdapter<DatabaseMessage> _databaseMessageDeletionAdapter;

  @override
  Future<List<DatabaseMessage>?> getMessagesByUserClientId(
      String clientId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM messages WHERE recipientClientId = ?1',
        mapper: (Map<String, Object?> row) => DatabaseMessage(
            primaryKey: row['primaryKey'] as int?,
            content: row['content'] as String,
            author: row['author'] as String,
            timestamp: row['timestamp'] as String,
            recipientClientId: row['recipientClientId'] as String,
            isUnread: (row['isUnread'] as int) != 0),
        arguments: [clientId]);
  }

  @override
  Future<DatabaseMessage?> getLatestMessageByUserClientId(
      String clientId) async {
    return _queryAdapter.query(
        'SELECT TOP 1 * FROM messages WHERE recipientClientId = ?1',
        mapper: (Map<String, Object?> row) => DatabaseMessage(
            primaryKey: row['primaryKey'] as int?,
            content: row['content'] as String,
            author: row['author'] as String,
            timestamp: row['timestamp'] as String,
            recipientClientId: row['recipientClientId'] as String,
            isUnread: (row['isUnread'] as int) != 0),
        arguments: [clientId]);
  }

  @override
  Future<int?> getNumberOfUnreadMessagesByUser(String clientId) async {
    return _queryAdapter.query(
        'SELECT COUNT(recipientClientId) FROM messages WHERE isUnread = TRUE AND recipientClientId = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [clientId]);
  }

  @override
  Future<void> markUnreadAsReadOfUser(String clientId) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE messages SET isUnread = FALSE WHERE isUnread = TRUE AND recipientClientId = ?1',
        arguments: [clientId]);
  }

  @override
  Future<void> deleteMessages() async {
    await _queryAdapter.queryNoReturn('DROP TABLE messages');
  }

  @override
  Future<void> deleteUsers() async {
    await _queryAdapter.queryNoReturn('DROP TABLE users');
  }

  @override
  Future<void> insertMessage(DatabaseMessage message) async {
    await _databaseMessageInsertionAdapter.insert(
        message, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMessage(DatabaseMessage message) async {
    await _databaseMessageDeletionAdapter.delete(message);
  }

  @override
  Future<void> editMessage(DatabaseMessage message) async {
    await _databaseMessageDeletionAdapter.delete(message);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _databaseUserInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (DatabaseUser item) => <String, Object?>{
                  'clientId': item.clientId,
                  'username': item.username
                }),
        _databaseUserUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['clientId'],
            (DatabaseUser item) => <String, Object?>{
                  'clientId': item.clientId,
                  'username': item.username
                }),
        _databaseUserDeletionAdapter = DeletionAdapter(
            database,
            'users',
            ['clientId'],
            (DatabaseUser item) => <String, Object?>{
                  'clientId': item.clientId,
                  'username': item.username
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DatabaseUser> _databaseUserInsertionAdapter;

  final UpdateAdapter<DatabaseUser> _databaseUserUpdateAdapter;

  final DeletionAdapter<DatabaseUser> _databaseUserDeletionAdapter;

  @override
  Future<List<DatabaseUser>?> getAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM users',
        mapper: (Map<String, Object?> row) => DatabaseUser(
            clientId: row['clientId'] as String,
            username: row['username'] as String));
  }

  @override
  Future<void> insertUser(DatabaseUser user) async {
    await _databaseUserInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> editUser(DatabaseUser user) async {
    await _databaseUserUpdateAdapter.update(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(DatabaseUser user) async {
    await _databaseUserDeletionAdapter.delete(user);
  }
}
