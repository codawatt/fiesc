cmake_minimum_required(VERSION 3.16)

project(Biblioteca VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(SQLite3 REQUIRED)

include_directories(include)

add_executable(Biblioteca
    src/main.cpp
    src/sql/sqlite_db.cpp
    src/sql/db_initializer.cpp
    src/ui/console_menu.cpp
)

target_link_libraries(Biblioteca PRIVATE SQLite::SQLite3)