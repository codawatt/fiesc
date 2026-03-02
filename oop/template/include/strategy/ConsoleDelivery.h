#pragma once
#include "strategy/IDeliveryStrategy.h"

class ConsoleDelivery final : public IDeliveryStrategy {
public:
    Result Deliver(const std::string& payload) override;
};