% Open a serial communication port (change 'COM' to your actual port)
s = serialport('COM', 9600);

% Configure the line terminator for incoming data
configureTerminator(s, "LF");

% Define the number of data values and storage size
numValues = 12;  
dataStorageSize = 1000;  

% Initialize a buffer to store incoming data
dataBuffer = zeros(dataStorageSize, numValues);

% Initialize an index to keep track of the buffer position
dataIndex = 1;

% Create a figure for the orientation plot
figure;

% Initialize arrays to store pitch, yaw, and roll data
pitch = zeros(100, 1);
yaw = zeros(100, 1);
roll = zeros(100, 1);

% Create animated lines for each data series
linePitch = animatedline('Color', 'b', 'LineWidth', 1.5);
lineYaw = animatedline('Color', 'g', 'LineWidth', 1.5);
lineRoll = animatedline('Color', 'r', 'LineWidth', 1.5);

% Set axis limits and labels for the orientation plot
axis([1 100 -300 500]);
xlabel('Time');
ylabel('Orientation (degrees)');
grid on;
legend('Pitch', 'Yaw', 'Roll');

% Create a figure for the acceleration plot
figure;

% Initialize arrays to store acceleration data
accelX = zeros(100, 1);
accelY = zeros(100, 1);
accelZ = zeros(100, 1);

% Create animated lines for each acceleration data series
lineAccelX = animatedline('Color', 'b', 'LineWidth', 1.5);
lineAccelY = animatedline('Color', 'g', 'LineWidth', 1.5);
lineAccelZ = animatedline('Color', 'r', 'LineWidth', 1.5);

% Set labels for the acceleration plot
xlabel('Time');
ylabel('Acceleration (m/s^2)');
grid on;
legend('AccelX', 'AccelY', 'AccelZ');

% Create a figure for the gyroscope plot
figure;

% Initialize arrays to store gyroscope data
gyroX = zeros(100, 1);
gyroY = zeros(100, 1);
gyroZ = zeros(100, 1);

% Create animated lines for each gyroscope data series
lineGyroX = animatedline('Color', 'b', 'LineWidth', 1.5);
lineGyroY = animatedline('Color', 'g', 'LineWidth', 1.5);
lineGyroZ = animatedline('Color', 'r', 'LineWidth', 1.5);

% Set labels for the gyroscope plot
xlabel('Time');
ylabel('Gyroscope (rad/s)');
grid on;
legend('GyroX', 'GyroY', 'GyroZ');

% Create a figure for the magnetic field plot
figure;

% Initialize arrays to store magnetic field data
magX = zeros(100, 1);
magY = zeros(100, 1);
magZ = zeros(100, 1);

% Create animated lines for each magnetic field data series
lineMagX = animatedline('Color', 'b', 'LineWidth', 1.5);
lineMagY = animatedline('Color', 'g', 'LineWidth', 1.5);
lineMagZ = animatedline('Color', 'r', 'LineWidth', 1.5);

% Set labels for the magnetic field plot
xlabel('Time');
ylabel('Magnetic Field (uT)');
grid on;
legend('MagX', 'MagY', 'MagZ');

% Flush the serial port and open the port for communication
flush(s);
fopen(s);

try
    x = 1:100;  % Time values for plotting
    
    % Main data reading and plotting loop
    while true
       dataLine = readline(s);
       values = str2double(strsplit(dataLine, ','));        

        % Check if the correct number of values is received
        if numel(values) == numValues
            pitchValue = values(1);
            yawValue = values(2);
            rollValue = values(3);
            accelXValue = values(4);
            accelYValue = values(5);
            accelZValue = values(6);
            gyroXValue = values(7);
            gyroYValue = values(8);
            gyroZValue = values(9);
            magXValue = values(10);
            magYValue = values(11);
            magZValue = values(12);

            % Store data in the buffer and update the index
            dataBuffer(dataIndex, :) = values;
            dataIndex = mod(dataIndex, dataStorageSize) + 1;

            % Print received data to the console
            fprintf('Pitch: %.2f\n', pitchValue);
            fprintf('Yaw: %.2f\n', yawValue);
            fprintf('Roll: %.2f\n', rollValue);
            fprintf('AccelX: %.2f\n', accelXValue);
            fprintf('AccelY: %.2f\n', accelYValue);
            fprintf('AccelZ: %.2f\n', accelZValue);
            fprintf('GyroX: %.2f\n', gyroXValue);
            fprintf('GyroY: %.2f\n', gyroYValue);
            fprintf('GyroZ: %.2f\n', gyroZValue);
            fprintf('MagX: %.2f\n', magXValue);
            fprintf('MagY: %.2f\n', magYValue);
            fprintf('MagZ: %.2f\n', magZValue);

            % Shift and update data arrays for plotting
            pitch = circshift(pitch, [1, 0]);
            yaw = circshift(yaw, [1, 0]);
            roll = circshift(roll, [1, 0]);
            accelX = circshift(accelX, [1, 0]);
            accelY = circshift(accelY, [1, 0]);
            accelZ = circshift(accelZ, [1, 0]);
            gyroX = circshift(gyroX, [1, 0]);
            gyroY = circshift(gyroY, [1, 0]);
            gyroZ = circshift(gyroZ, [1, 0]);
            magX = circshift(magX, [1, 0]);
            magY = circshift(magY, [1, 0]);
            magZ = circshift(magZ, [1, 0]);

            % Update current data points
            pitch(1) = pitchValue;
            yaw(1) = yawValue;
            roll(1) = rollValue;
            accelX(1) = accelXValue;
            accelY(1) = accelYValue;
            accelZ(1) = accelZValue;
            gyroX(1) = gyroXValue;
            gyroY(1) = gyroYValue;
            gyroZ(1) = gyroZValue;
            magX(1) = magXValue;
            magY(1) = magYValue;
            magZ(1) = magZValue;

            % Update plot axis limits
            yMin = min([min(pitch), min(yaw), min(roll)]) - 10;
            yMax = max([max(pitch), max(yaw), max(roll)]) + 10;
            ylim([yMin, yMax]);

            yMinAccel = min([min(accelX), min(accelY), min(accelZ)]) - 10;
            yMaxAccel = max([max(accelX), max(accelY), max(accelZ)]) + 10;
            ylim(lineAccelX.Parent, [yMinAccel, yMaxAccel]);

            yMinGyro = min([min(gyroX), min(gyroY), min(gyroZ)]) - 10;
            yMaxGyro = max([max(gyroX), max(gyroY), max(gyroZ)]) + 10;
            ylim(lineGyroX.Parent, [yMinGyro, yMaxGyro]);

            yMinMag = min([min(magX), min(magY), min(magZ)]) - 10;
            yMaxMag = max([max(magX), max(magY), max(magZ)]) + 10;
            ylim(lineMagX.Parent, [yMinMag, yMaxMag]);
            
            % Clear and update data points in the animated lines
            clearpoints(linePitch);
            clearpoints(lineYaw);
            clearpoints(lineRoll);
            clearpoints(lineAccelX);
            clearpoints(lineAccelY);
            clearpoints(lineAccelZ);
            clearpoints(lineGyroX);
            clearpoints(lineGyroY);
            clearpoints(lineGyroZ);
            clearpoints(lineMagX);
            clearpoints(lineMagY);
            clearpoints(lineMagZ);

            addpoints(linePitch, x, pitch);
            addpoints(lineYaw, x, yaw);
            addpoints(lineRoll, x, roll);
            addpoints(lineAccelX, x, accelX);
            addpoints(lineAccelY, x, accelY);
            addpoints(lineAccelZ, x, accelZ);
            addpoints(lineGyroX, x, gyroX);
            addpoints(lineGyroY, x, gyroY);
            addpoints(lineGyroZ, x, gyroZ);
            addpoints(lineMagX, x, magX);
            addpoints(lineMagY, x, magY);
            addpoints(lineMagZ, x, magZ);

            drawnow;  % Update the plots
        else
            fprintf('Received invalid data: %s\n', dataLine);
        end
    end
catch e
    fprintf('Error reading data: %s\n', e.message);
end

% Close the serial port
fclose(s);

% Delete the serial port object
delete(s);

% Clear the serial port object from the workspace
clear s;
