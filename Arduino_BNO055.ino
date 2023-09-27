#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>

Adafruit_BNO055 bno = Adafruit_BNO055();

void setup() {
  Serial.begin(9600);
  if (!bno.begin()) {
    Serial.println("Could not find a valid BNO055 sensor, check wiring!");
    while (1);
  }
  bno.setExtCrystalUse(true);
}

void loop() {
  sensors_event_t orientationData, accelData, gyroData, magData;
  bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
  bno.getEvent(&accelData, Adafruit_BNO055::VECTOR_ACCELEROMETER);
  bno.getEvent(&gyroData, Adafruit_BNO055::VECTOR_GYROSCOPE);
  bno.getEvent(&magData, Adafruit_BNO055::VECTOR_MAGNETOMETER);

  Serial.print(orientationData.orientation.x); Serial.print(",");
  Serial.print(orientationData.orientation.y); Serial.print(",");
  Serial.print(orientationData.orientation.z); Serial.print(",");
  
  Serial.print(accelData.acceleration.x); Serial.print(",");
  Serial.print(accelData.acceleration.y); Serial.print(",");
  Serial.print(accelData.acceleration.z); Serial.print(",");
  
  Serial.print(gyroData.gyro.x); Serial.print(",");
  Serial.print(gyroData.gyro.y); Serial.print(",");
  Serial.print(gyroData.gyro.z); Serial.print(",");
  
  Serial.print(magData.magnetic.x); Serial.print(",");
  Serial.print(magData.magnetic.y); Serial.print(",");
  Serial.print(magData.magnetic.z); Serial.println();

  delay(100);  
}
