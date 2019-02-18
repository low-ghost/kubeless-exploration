"""
Python kafka producer using kafka-python.
With any luck, calling this function will publish to kafka topic,
which will then trigger the subscribed functions
"""

import json
from kafka import KafkaProducer

KAFKA_HOST = 'kafka.kubeless'
KAFKA_PORT = '9092'


def send_message(event, context):
    """Send message to the 'hello' topic after json encoding it"""
    print('sending event', event['data'])
    producer = KafkaProducer(
        bootstrap_servers='{}:{}'.format(KAFKA_HOST, KAFKA_PORT),
        value_serializer=lambda v: json.dumps(v).encode('utf-8'))
    msg = {'type': 'python-event', 'object': event['data']}
    topic = 'example'
    producer.send(topic, msg)
    producer.flush()
    return json.dumps({'success': True, 'message': 'sent message'})
