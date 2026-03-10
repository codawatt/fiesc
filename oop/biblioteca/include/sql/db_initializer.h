#ifndef DB_INITIALIZER_H
#define DB_INITIALIZER_H

#include <string>

class SQLiteDB;

class DBInitializer {
public:
    static void initialize(SQLiteDB& db, const std::string& schemaFilePath);

private:
    static std::string readFileContent(const std::string& filePath);
};

#endif