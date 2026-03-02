#pragma once
#include <string>
#include <mutex>

class AppConfig {
public:
    static AppConfig& Instance();

    void SetAppName(std::string name);
    const std::string& AppName() const;

    void SetEnvironment(std::string env);
    const std::string& Environment() const;

private:
    AppConfig() = default;

    std::string appName_{"solid_patterns"};
    std::string environment_{"dev"};

    static std::once_flag once_;
    static AppConfig* instance_;
};