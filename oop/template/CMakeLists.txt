cmake_minimum_required(VERSION 3.20)
project(solid_patterns LANGUAGES CXX)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(solid_patterns
  src/main.cpp
  src/core/AppConfig.cpp
  src/messaging/Message.cpp
  src/messaging/TimestampDecorator.cpp
  src/notify/NotifierFactory.cpp
  src/observer/EventBus.cpp
  src/strategy/ConsoleDelivery.cpp
  src/strategy/BufferedDelivery.cpp
)

target_include_directories(solid_patterns PRIVATE include)