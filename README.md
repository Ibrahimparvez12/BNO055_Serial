# BNO055 Sensor Data Visualization

This repository contains Arduino and MATLAB code to interface with an Adafruit BNO055 sensor and visualize its data in real-time.

## Description

The Arduino code reads data from the BNO055 sensor, including orientation, acceleration, gyroscope, and magnetometer data. It sends this data over a serial connection.

The MATLAB code establishes a serial connection with the Arduino, receives the data, and visualizes it in real-time using plots.

## Hardware Setup

1. Connect the Adafruit BNO055 sensor to your Arduino following the wiring instructions.

## Usage

1. Upload the Arduino code to your Arduino board.
2. Run the MATLAB code and ensure it's connected to the correct COM port.
3. Visualize real-time data from the BNO055 sensor.

## Dependencies

- Arduino IDE
- MATLAB

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
