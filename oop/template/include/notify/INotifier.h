#pragma once
#include <string>
#include <memory>
#include "observer/IObserver.h"
#include "strategy/IDeliveryStrategy.h"
#include "core/AppConfig.h"

class INotifier : public IObserver {
public:
    virtual ~INotifier() = default;
    virtual void Notify(const std::string& payload) = 0;
};

class NotifierBase : public INotifier {
public:
    explicit NotifierBase(std::unique_ptr<IDeliveryStrategy> strategy)
        : strategy_(std::move(strategy)) {}

    void OnEvent(const std::string& eventName, const std::string& payload) override {
        std::string composed = AppConfig::Instance().AppName() + ":" + eventName + ":" + payload;
        Notify(composed);
    }

protected:
    IDeliveryStrategy& Strategy() { return *strategy_; }

private:
    std::unique_ptr<IDeliveryStrategy> strategy_;
};

class ConsoleNotifier final : public NotifierBase {
public:
    using NotifierBase::NotifierBase;
    void Notify(const std::string& payload) override { Strategy().Deliver(payload); }
};

class BufferedNotifier final : public NotifierBase {
public:
    using NotifierBase::NotifierBase;
    void Notify(const std::string& payload) override { Strategy().Deliver(payload); }
};