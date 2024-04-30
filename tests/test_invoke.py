import operator
import unittest

import template


class TestInvoke(unittest.TestCase):
    def test_addition(self) -> None:
        self.assertEqual(template.invoke(operator.add, 1, 2), 3)
