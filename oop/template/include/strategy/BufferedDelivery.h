#pragma once
#include "strategy/IDeliveryStrategy.h"
#include <vector>
#include <string>

class BufferedDelivery final : public IDeliveryStrategy {
public:
    Result Deliver(const std::string& payload) override;
    const std::vector<std::string>& Buffer() const;

private:
    std::vector<std::string> buffer_{};
};