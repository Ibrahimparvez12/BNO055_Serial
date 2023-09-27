s = serialport('COM5', 9600);
configureTerminator(s, "LF");
numValues = 12;  
dataStorageSize = 1000;  
dataBuffer = zeros(dataStorageSize, numValues);
dataIndex = 1;
figure;

% Orientation plot 
pitch = zeros(100, 1);
yaw = zeros(100, 1);
roll = zeros(100, 1);
linePitch = animatedline('Color', 'b', 'LineWidth', 1.5);
lineYaw = animatedline('Color', 'g', 'LineWidth', 1.5);
lineRoll = animatedline('Color', 'r', 'LineWidth', 1.5);
axis([1 100 -300 500]);  
xlabel('Time');
ylabel('Orientation (degrees)');
grid on;
legend('Pitch', 'Yaw', 'Roll');

% Acceleration plot 
figure;
accelX = zeros(100, 1);
accelY = zeros(100, 1);
accelZ = zeros(100, 1);
lineAccelX = animatedline('Color', 'b', 'LineWidth', 1.5);
lineAccelY = animatedline('Color', 'g', 'LineWidth', 1.5);
lineAccelZ = animatedline('Color', 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Acceleration (m/s^2)');
grid on;
legend('AccelX', 'AccelY', 'AccelZ');

% Gyroscope plot 
figure;
gyroX = zeros(100, 1);
gyroY = zeros(100, 1);
gyroZ = zeros(100, 1);
lineGyroX = animatedline('Color', 'b', 'LineWidth', 1.5);
lineGyroY = animatedline('Color', 'g', 'LineWidth', 1.5);
lineGyroZ = animatedline('Color', 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Gyroscope (rad/s)');
grid on;
legend('GyroX', 'GyroY', 'GyroZ');

figure;
magX = zeros(100, 1);
magY = zeros(100, 1);
magZ = zeros(100, 1);
lineMagX = animatedline('Color', 'b', 'LineWidth', 1.5);
lineMagY = animatedline('Color', 'g', 'LineWidth', 1.5);
lineMagZ = animatedline('Color', 'r', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Magnetic Field (uT)');
grid on;
legend('MagX', 'MagY', 'MagZ');

flush(s);
fopen(s);

try
    x = 1:100;  
    while true
       dataLine = readline(s);
        values = str2double(strsplit(dataLine, ','));        
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

            
            dataBuffer(dataIndex, :) = values;
            dataIndex = mod(dataIndex, dataStorageSize) + 1;
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

            drawnow;  
        else
            fprintf('Received invalid data: %s\n', dataLine);
        end
    end
catch e
    fprintf('Error reading data: %s\n', e.message);
end
fclose(s);
delete(s);
clear s;
