import typing

Ts = typing.ParamSpec("Ts")
R = typing.TypeVar("R")


# def invoke[**Ts, R](...): ...
def invoke(
    f: typing.Callable[Ts, R], *args: Ts.args, **kwargs: Ts.kwargs
) -> R:
    return f(*args, **kwargs)


def main() -> None:
    invoke(print, "Hello, world!")
