#pragma once
#include <string>

class IMessage {
public:
    virtual ~IMessage() = default;
    virtual std::string Text() const = 0;
};