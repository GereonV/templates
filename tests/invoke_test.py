import operator

import template


def test_addition() -> None:
    assert template.invoke(operator.add, 1, 2) == 3
