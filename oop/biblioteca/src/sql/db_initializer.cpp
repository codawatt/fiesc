#include "sql/db_initializer.h"
#include "sql/sqlite_db.h"

#include <fstream>
#include <sstream>
#include <stdexcept>

void DBInitializer::initialize(SQLiteDB& db, const std::string& schemaFilePath) {
    const std::string sql = readFileContent(schemaFilePath);
    db.execute(sql);
}

std::string DBInitializer::readFileContent(const std::string& filePath) {
    std::ifstream file(filePath);
    if (!file.is_open()) {
        throw std::runtime_error("Nu s-a putut deschide fisierul schema: " + filePath);
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}