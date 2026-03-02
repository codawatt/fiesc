#pragma once
#include <string>
#include "core/Result.h"

class IDeliveryStrategy {
public:
    virtual ~IDeliveryStrategy() = default;
    virtual Result Deliver(const std::string& payload) = 0;
};