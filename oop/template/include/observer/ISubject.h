#pragma once
#include <memory>
#include "observer/IObserver.h"

class ISubject {
public:
    virtual ~ISubject() = default;
    virtual void Subscribe(std::shared_ptr<IObserver> obs) = 0;
    virtual void Unsubscribe(const std::shared_ptr<IObserver>& obs) = 0;
    virtual void Publish(const std::string& eventName, const std::string& payload) = 0;
};