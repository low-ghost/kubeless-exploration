package kubeless

import (
	"github.com/kubeless/kubeless/pkg/functions"
	"github.com/sirupsen/logrus"
	"github.com/confluentinc/confluent-kafka-go/kafka"
)

// Hello sample function with dependencies
func Produce(event functions.Event, context functions.Context) (string, error) {
	p, err := kafka.NewProducer(&kafka.ConfigMap{"bootstrap.servers": "kafka.kubeless"})
	if err != nil {
		panic(err)
	}
	defer p.Close()

	// Delivery report handler for produced messages
	go func() {
		for e := range p.Events() {
			switch ev := e.(type) {
			case *kafka.Message:
				if ev.TopicPartition.Error != nil {
					fmt.Printf("Delivery failed: %v\n", ev.TopicPartition)
				} else {
					fmt.Printf("Delivered message to %v\n", ev.TopicPartition)
				}
			}
		}
	}()

	// Produce messages to topic (asynchronously)
	topic := "hello"
	for _, word := range []string{"Welcome", "to", "the", "Confluent", "Kafka", "Golang", "client"} {
		p.Produce(&kafka.Message{
			TopicPartition: kafka.TopicPartition{Topic: &topic, Partition: kafka.PartitionAny},
			Value:          []byte(word),
		}, nil)
	}

	// Wait for message deliveries before shutting down
	p.Flush(15 * 1000)

	return "Published topics!", nil
}
