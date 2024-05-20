#ifndef TEMPLATE_TEMPLATE_HPP
#define TEMPLATE_TEMPLATE_HPP

namespace tmplt {
    template<typename F, typename... Args>
    constexpr decltype(auto)
    invoke(F && f, Args &&... args) noexcept(noexcept(static_cast<F &&>(f)(static_cast<Args &&>(args)...)))
    {
        return static_cast<F &&>(f)(static_cast<Args &&>(args)...);
    }

    // invoke impl
}

#endif
