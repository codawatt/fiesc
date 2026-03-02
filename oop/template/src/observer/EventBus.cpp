#include "observer/EventBus.h"
#include <algorithm>

void EventBus::Subscribe(std::shared_ptr<IObserver> obs) {
    observers_.push_back(std::move(obs));
}

void EventBus::Unsubscribe(const std::shared_ptr<IObserver>& obs) {
    observers_.erase(
        std::remove_if(observers_.begin(), observers_.end(),
            [&](const std::shared_ptr<IObserver>& x) { return x == obs; }),
        observers_.end()
    );
}

void EventBus::Publish(const std::string& eventName, const std::string& payload) {
    for (auto& o : observers_) {
        if (o) o->OnEvent(eventName, payload);
    }
}