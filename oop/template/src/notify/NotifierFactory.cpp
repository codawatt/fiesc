#include "notify/NotifierFactory.h"
#include "strategy/ConsoleDelivery.h"
#include "strategy/BufferedDelivery.h"
#include <stdexcept>

std::shared_ptr<INotifier> NotifierFactory::Create(const std::string& kind) {
    if (kind == "console") {
        return std::make_shared<ConsoleNotifier>(std::make_unique<ConsoleDelivery>());
    }
    if (kind == "buffered") {
        return std::make_shared<BufferedNotifier>(std::make_unique<BufferedDelivery>());
    }
    throw std::invalid_argument("unknown notifier kind");
}