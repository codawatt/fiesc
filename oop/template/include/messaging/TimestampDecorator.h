#pragma once
#include "messaging/MessageDecorator.h"

class TimestampDecorator final : public MessageDecorator {
public:
    explicit TimestampDecorator(std::unique_ptr<IMessage> inner);
    std::string Text() const override;
};