#pragma once
#include "observer/ISubject.h"
#include <vector>
#include <memory>

class EventBus final : public ISubject {
public:
    void Subscribe(std::shared_ptr<IObserver> obs) override;
    void Unsubscribe(const std::shared_ptr<IObserver>& obs) override;
    void Publish(const std::string& eventName, const std::string& payload) override;

private:
    std::vector<std::shared_ptr<IObserver>> observers_{};
};