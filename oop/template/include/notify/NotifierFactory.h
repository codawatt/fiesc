#pragma once
#include <memory>
#include <string>
#include "notify/INotifier.h"

class NotifierFactory {
public:
    static std::shared_ptr<INotifier> Create(const std::string& kind);
};