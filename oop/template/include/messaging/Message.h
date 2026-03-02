#pragma once
#include "messaging/IMessage.h"
#include <string>

class Message final : public IMessage {
public:
    explicit Message(std::string text);
    std::string Text() const override;

private:
    std::string text_;
};