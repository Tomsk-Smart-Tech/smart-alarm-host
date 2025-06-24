import time
import board
import adafruit_dht
import RPi.GPIO as GPIO


import math
import time
import board
import adafruit_dht
import adafruit_sgp40


dhtDevice = adafruit_dht.DHT22(board.D4,use_pulseio=False)
i2c=board.I2C()
sgp = adafruit_sgp40.SGP40(i2c)
temperature_c=0
humidity=0
while True:
    try:
        # Print the values to the serial port
        temperature_c = dhtDevice.temperature
        humidity = dhtDevice.humidity
        voc_index=sgp.measure_index(temperature=temperature_c,relative_humidity=humidity)
        print(str(temperature_c)+" "+str(round(humidity))+" "+str(voc_index),flush=True)
        

    except RuntimeError as error:
        # Errors happen fairly often, DHT's are hard to read, just keep going
        print(error.args[0])
        voc_index=sgp.measure_index(temperature=temperature_c,relative_humidity=humidity)
        continue
    except Exception as error:
        dhtDevice.exit()
        raise error

    time.sleep(1.0)
