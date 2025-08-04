# Implement a Real-time Security Tool Monitor

require 'socket'
require 'json'

class SecurityMonitor
  def initialize
    @socket = UDPSocket.new
    @socket.bind("localhost", 8080)
    @alerts = []
  end

  def start_monitoring
    puts "Security Monitor started. Listening for alerts..."
    loop do
      message, sender = @socket.recvfrom(1024)
      alert = JSON.parse(message)
      process_alert(alert)
    end
  end

  def process_alert(alert)
    # Implement logic to process and analyze the alert
    # For example, you can check the alert level and send notifications
    if alert["level"] == "CRITICAL"
      send_notification("Critical alert received: #{alert["message"]}")
    else
      puts "Received alert: #{alert["message"]}"
    end
    @alerts << alert
  end

  def send_notification(message)
    # Implement logic to send notifications (e.g., email, SMS, etc.)
    puts "Sending notification: #{message}"
  end

  def view_alerts
    puts "Recent alerts:"
    @alerts.each do |alert|
      puts "  - #{alert["message"]}"
    end
  end
end

monitor = SecurityMonitor.new
monitor.start_monitoring

# Example usage:
# monitor.view_alerts

# To simulate an alert, send a UDP packet to localhost:8080 with a JSON payload
# For example: echo '{"level": "INFO", "message": "System update available"}' | nc -u localhost 8080