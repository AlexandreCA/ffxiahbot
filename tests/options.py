"""
.. moduleauthor:: Adam Gagorik <adam.gagorik@gmail.com>
"""
import unittest
import pydarkstar.logutils
import pydarkstar.database
import pydarkstar.options

pydarkstar.logutils.setDebug()

class TestOptions(unittest.TestCase):
    def test_init(self):
        pydarkstar.options.Options()

if __name__ == '__main__':
    unittest.main()