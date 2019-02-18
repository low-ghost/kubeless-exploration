"""Simple kubeless function example in python"""


def simple_function(event, context):
    """Print basic info before returning event data."""
    print('executing simple_function')
    print('event: ', event)
    print('context: ', context)
    return event['data']
