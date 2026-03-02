#pragma once
#include "messaging/IMessage.h"
#include <memory>

class MessageDecorator : public IMessage {
public:
    explicit MessageDecorator(std::unique_ptr<IMessage> inner);
    std::string Text() const override = 0;

protected:
    const IMessage& Inner() const;

private:
    std::unique_ptr<IMessage> inner_;
};