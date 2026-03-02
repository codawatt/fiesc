#include "messaging/Message.h"

Message::Message(std::string text) : text_(std::move(text)) {}

std::string Message::Text() const {
    return text_;
}