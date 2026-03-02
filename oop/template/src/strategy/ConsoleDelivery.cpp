#include "strategy/ConsoleDelivery.h"
#include <iostream>

Result ConsoleDelivery::Deliver(const std::string& payload) {
    std::cout << payload << std::endl;
    return Result::Success();
}