#
# Skeleton file for the Python "Hello World" exercise.
#

def hello(name=''):
    name = 'World' if name == '' or name == None else name
    return u'Hello, {name}!'.format(name=name)
