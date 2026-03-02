#include "messaging/TimestampDecorator.h"
#include <chrono>
#include <ctime>
#include <iomanip>
#include <sstream>

MessageDecorator::MessageDecorator(std::unique_ptr<IMessage> inner) : inner_(std::move(inner)) {}

const IMessage& MessageDecorator::Inner() const {
    return *inner_;
}

TimestampDecorator::TimestampDecorator(std::unique_ptr<IMessage> inner) : MessageDecorator(std::move(inner)) {}

std::string TimestampDecorator::Text() const {
    auto now = std::chrono::system_clock::now();
    std::time_t t = std::chrono::system_clock::to_time_t(now);
    std::tm tm{};
#if defined(_WIN32)
    localtime_s(&tm, &t);
#else
    localtime_r(&t, &tm);
#endif
    std::ostringstream oss;
    oss << "[" << std::put_time(&tm, "%Y-%m-%d %H:%M:%S") << "] " << Inner().Text();
    return oss.str();
}