% Aircraft Performance Calculator
% Mini-project for analyzing lift and drag forces with user-defined inputs.

clc;
clear;
% User Prompts
disp('Aircraft Performance Calculator');
altitude = input('Enter altitude in meters: ');
wing_area = input('Enter wing area in m^2: ');
cl = input('Enter lift coefficient (Cl): ');
cd = input('Enter drag coefficient (Cd): ');
v_min = input('Enter minimum velocity in m/s: ');
v_max = input('Enter maximum velocity in m/s: ');
num_points = input('Enter the number of points for velocity range: ');

% Calculate air density (rho) using ISA model approximation
if altitude <= 11000
% Troposphere (up to 11 km)
rho = 1.225 * (1 - 0.0000225577 * altitude)^4.2561; % Density in kg/m^3
elseif altitude > 11000 && altitude <= 40000
% Lower stratosphere (11 km to 40 km, isothermal layer)
rho = 0.36391 * exp(-(altitude - 11000) / 6341.62);
else
error('Altitude exceeds 40,000 meters. Model not valid.');
end

% Velocity range
velocity = linspace(v_min, v_max, num_points);

lift = 0.5 * rho * velocity.^2 * wing_area * cl; % Lift force (N)
drag = 0.5 * rho * velocity.^2 * wing_area * cd; % Drag force (N)

power_required = drag .* velocity; % Power (W)

efficiency_ratio = lift ./ drag; % Lift-to-drag ratio

% Plotting Lift and Drag vs Velocity
figure;
plot(velocity, lift, 'b', 'LineWidth', 1.5);
hold on;
plot(velocity, drag, 'r--', 'LineWidth', 1.5);
hold off;
title(['Lift and Drag vs Velocity at Altitude ', num2str(altitude), ' meters']);
xlabel('Velocity (m/s)');
ylabel('Force (N)');
legend('Lift (N)', 'Drag (N)');
grid on;

% Plotting
figure;
plot(velocity, power_required, 'g', 'LineWidth', 1.5);
title(['Power Required vs Velocity at Altitude ', num2str(altitude), ' meters']);
xlabel('Velocity (m/s)');
ylabel('Power (W)');
grid on;

% Plotting Lift-to-Drag Ratio vs Velocity
figure;
plot(velocity, efficiency_ratio, 'm', 'LineWidth', 1.5);
title(['Lift-to-Drag Ratio vs Velocity at Altitude ', num2str(altitude), ' meters']);
xlabel('Velocity (m/s)');
ylabel('Lift-to-Drag Ratio');
grid on;

% Display Key Results
disp('---- Calculation Results ----');
disp(['Air density at ', num2str(altitude), ' meters: ', num2str(rho), ' kg/m^3']);
disp(['Maximum Lift Force: ', num2str(max(lift)), ' N']);
disp(['Maximum Drag Force: ', num2str(max(drag)), ' N']);
disp(['Maximum Power Required: ', num2str(max(power_required)), ' W']);
disp(['Maximum Lift-to-Drag Ratio: ', num2str(max(efficiency_ratio))]);