// Include necessary libraries
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>

// Create an instance of the Adafruit BNO055 sensor
Adafruit_BNO055 bno = Adafruit_BNO055();

// Setup function: runs once at the beginning
void setup() {
  // Initialize the serial communication for debugging
  Serial.begin(9600);

  // Check if the BNO055 sensor is detected and initialize it
  if (!bno.begin()) {
    Serial.println("Could not find a valid BNO055 sensor, check wiring!");
    while (1);  // Stuck in an infinite loop if sensor is not found
  }

  // Use an external crystal for better accuracy
  bno.setExtCrystalUse(true);
}

// Loop function: runs repeatedly
void loop() {
  // Create variables to store sensor data
  sensors_event_t orientationData, accelData, gyroData, magData;

  // Read sensor data from the BNO055 sensor
  bno.getEvent(&orientationData, Adafruit_BNO055::VECTOR_EULER);
  bno.getEvent(&accelData, Adafruit_BNO055::VECTOR_ACCELEROMETER);
  bno.getEvent(&gyroData, Adafruit_BNO055::VECTOR_GYROSCOPE);
  bno.getEvent(&magData, Adafruit_BNO055::VECTOR_MAGNETOMETER);

  // Print orientation data (X, Y, Z)
  Serial.print(orientationData.orientation.x); Serial.print(",");
  Serial.print(orientationData.orientation.y); Serial.print(",");
  Serial.print(orientationData.orientation.z); Serial.print(",");

  // Print acceleration data (X, Y, Z)
  Serial.print(accelData.acceleration.x); Serial.print(",");
  Serial.print(accelData.acceleration.y); Serial.print(",");
  Serial.print(accelData.acceleration.z); Serial.print(",");

  // Print gyroscope data (X, Y, Z)
  Serial.print(gyroData.gyro.x); Serial.print(",");
  Serial.print(gyroData.gyro.y); Serial.print(",");
  Serial.print(gyroData.gyro.z); Serial.print(",");

  // Print magnetic field data (X, Y, Z)
  Serial.print(magData.magnetic.x); Serial.print(",");
  Serial.print(magData.magnetic.y); Serial.print(",");
  Serial.print(magData.magnetic.z); Serial.println();

  // Delay for a short period (100 milliseconds)
  delay(100);
}
