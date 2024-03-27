import operator
import unittest

import template


class TestInvoke(unittest.TestCase):
    def test_addition(self):
        self.assertEqual(template.invoke(operator.add, 1, 2), 3)


if __name__ == "__main__":
    unittest.main()
