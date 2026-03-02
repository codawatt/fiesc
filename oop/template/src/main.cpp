#include "core/AppConfig.h"
#include "observer/EventBus.h"
#include "notify/NotifierFactory.h"
#include "messaging/Message.h"
#include "messaging/TimestampDecorator.h"
#include "strategy/BufferedDelivery.h"
#include <memory>
#include <string>
#include <vector>

int main() {
    auto& cfg = AppConfig::Instance();
    cfg.SetAppName("solid_patterns");
    cfg.SetEnvironment("dev");

    EventBus bus;

    auto console = NotifierFactory::Create("console");
    auto buffered = NotifierFactory::Create("buffered");

    bus.Subscribe(console);
    bus.Subscribe(buffered);

    auto publishDecorated = [&](const std::string& eventName, const std::string& payload) {
        std::unique_ptr<IMessage> msg = std::make_unique<Message>(payload);
        msg = std::make_unique<TimestampDecorator>(std::move(msg));
        bus.Publish(eventName, msg->Text());
    };

    publishDecorated("app.boot", "env=" + cfg.Environment());

    std::vector<std::string> steps{
        "configure cmake",
        "generate build files",
        "compile targets",
        "link executable",
        "run smoke tests"
    };

    for (std::size_t i = 0; i < steps.size(); ++i) {
        publishDecorated(
            "build.step",
            "index=" + std::to_string(i) + " name=" + steps[i]
        );
    }

    publishDecorated("build.result", "status=success");

    auto bufferedNotifier = std::dynamic_pointer_cast<BufferedNotifier>(buffered);
    if (bufferedNotifier) {
        publishDecorated("buffer.inspect", "kind=buffered_notifier");
    }

    publishDecorated("app.shutdown", "bye");

    return 0;
}