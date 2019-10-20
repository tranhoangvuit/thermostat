thermostat = Thermostat.first

Reading.find_or_create_by!(thermostat: thermostat, temperature: 25.4, humidity: 50, battery_charge: 90, tracking_number: 1)