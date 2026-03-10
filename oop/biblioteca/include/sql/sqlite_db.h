#ifndef SQLITE_DB_H
#define SQLITE_DB_H

#include <sqlite3.h>
#include <string>
#include <stdexcept>

class SQLiteDB {
public:
    explicit SQLiteDB(const std::string& dbPath);
    ~SQLiteDB();

    SQLiteDB(const SQLiteDB&) = delete;
    SQLiteDB& operator=(const SQLiteDB&) = delete;

    sqlite3* getConnection() const;

    void execute(const std::string& sql);
    bool isOpen() const;

private:
    sqlite3* db_;
};

#endif