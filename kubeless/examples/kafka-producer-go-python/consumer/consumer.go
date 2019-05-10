package kubeless

import (
	"github.com/kubeless/kubeless/pkg/functions"
	"github.com/sirupsen/logrus"
)

// Hello sample function with dependencies
func ReadMessage(event functions.Event, context functions.Context) (string, error) {
	logrus.Info(event.Data)
	return "Received message from kafka", nil
}
