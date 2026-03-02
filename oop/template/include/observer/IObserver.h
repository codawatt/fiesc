#pragma once
#include <string>

class IObserver {
public:
    virtual ~IObserver() = default;
    virtual void OnEvent(const std::string& eventName, const std::string& payload) = 0;
};