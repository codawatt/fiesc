#include "strategy/BufferedDelivery.h"

Result BufferedDelivery::Deliver(const std::string& payload) {
    buffer_.push_back(payload);
    return Result::Success();
}

const std::vector<std::string>& BufferedDelivery::Buffer() const {
    return buffer_;
}