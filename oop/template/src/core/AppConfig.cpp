#include "core/AppConfig.h"

std::once_flag AppConfig::once_;
AppConfig* AppConfig::instance_ = nullptr;

AppConfig& AppConfig::Instance() {
    std::call_once(once_, [] { instance_ = new AppConfig(); });
    return *instance_;
}

void AppConfig::SetAppName(std::string name) {
    appName_ = std::move(name);
}

const std::string& AppConfig::AppName() const {
    return appName_;
}

void AppConfig::SetEnvironment(std::string env) {
    environment_ = std::move(env);
}

const std::string& AppConfig::Environment() const {
    return environment_;
}