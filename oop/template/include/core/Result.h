#pragma once
#include <string>

struct Result {
    bool ok{};
    std::string message{};

    static Result Success(std::string msg = {}) { return Result{true, std::move(msg)}; }
    static Result Failure(std::string msg) { return Result{false, std::move(msg)}; }
};