import typing


def invoke[R, **Ts](
        f: typing.Callable[Ts, R],
        *args: Ts.args,
        **kwargs: Ts.kwargs
) -> R:
    return f(*args, **kwargs)


if __name__ == "__main__":
    invoke(print, "Hello, world!")
