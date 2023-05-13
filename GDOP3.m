%EECE5698-ST: GNSS signal processing
% MATLAB code to compute the GDOP for varying satellite geometry and number of satellites
% Prathamesh Rege, Spring 2023

clc;
clear all;
close all;

% Specify the position of the receiver
receiver_position = [0; 0; 0];

% Specify the positions of the satellites
num_satellites = 20;
satellite_positions = 2.02E7*rand(num_satellites, 3); % random positions

% Specify the range measurement noise standard deviation
range_noise_std_dev = 5; % meters

% Specify the number of simulations to run
num_simulations = 6;

% Simulate different satellite geometries
for i = 1:num_simulations
    % Add noise to the satellite positions
    satellite_positions_noisy = satellite_positions + range_noise_std_dev * rand(size(satellite_positions));
    
    % Calculate the range from the receiver to each satellite
    ranges = sqrt(sum((satellite_positions_noisy - receiver_position').^2, 2));
    
    % Calculate the unit vectors from the receiver to each satellite
    unit_vectors = (satellite_positions_noisy - receiver_position')./ranges;
    
    % Calculate the GDOP for the current geometry
    gdop = sqrt(trace(inv(unit_vectors'*unit_vectors)));
    
    % Plot the satellite positions
    figure;
    scatter3(satellite_positions_noisy(:,1), satellite_positions_noisy(:,2), satellite_positions_noisy(:,3), 'filled');
    hold on;
    scatter3(receiver_position(1), receiver_position(2), receiver_position(3), 100, 'r', 'filled');
    title(sprintf('Satellite Geometry for Simulation %d (GDOP=%.2f)', i, gdop));
    xlabel('X Position (m)');
    ylabel('Y Position (m)');
    zlabel('Z Position (m)');
    legend('Satellite Positions', 'Receiver Position');
    grid on;
    
    % Update the positions of the satellites for the next simulation
    satellite_positions = randn(num_satellites, 3); % random positions
end
