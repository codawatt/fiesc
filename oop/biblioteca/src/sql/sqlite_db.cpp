#include "sql/sqlite_db.h"

SQLiteDB::SQLiteDB(const std::string& dbPath) : db_(nullptr) {
    int rc = sqlite3_open(dbPath.c_str(), &db_);
    if (rc != SQLITE_OK) {
        std::string errorMessage = "Eroare la deschiderea bazei de date: ";
        errorMessage += sqlite3_errmsg(db_);
        if (db_ != nullptr) {
            sqlite3_close(db_);
            db_ = nullptr;
        }
        throw std::runtime_error(errorMessage);
    }

    execute("PRAGMA foreign_keys = ON;");
}

SQLiteDB::~SQLiteDB() {
    if (db_ != nullptr) {
        sqlite3_close(db_);
        db_ = nullptr;
    }
}

sqlite3* SQLiteDB::getConnection() const {
    return db_;
}

void SQLiteDB::execute(const std::string& sql) {
    char* errorMessage = nullptr;
    int rc = sqlite3_exec(db_, sql.c_str(), nullptr, nullptr, &errorMessage);

    if (rc != SQLITE_OK) {
        std::string message = "Eroare SQL: ";
        if (errorMessage != nullptr) {
            message += errorMessage;
            sqlite3_free(errorMessage);
        }
        throw std::runtime_error(message);
    }
}

bool SQLiteDB::isOpen() const {
    return db_ != nullptr;
}