clc; clear; close all

% 1. Rotation matrix about Y-axis
Ry = @(theta) [cos(theta) 0 sin(theta); 0 1 0; -sin(theta) 0 cos(theta)];

% 2. Vertical line coordinates 
L1 = [1 1; 1 1; 1 2];

theta = 0:0.03:10*pi;

figure('Color','w')
hold on

% Initial position of rotating vertical line [cite: 45]
L2 = Ry(theta(1)) * L1; 

% Plot rotating vertical line and end points [cite: 46, 47]
hLine = plot3(L2(1,:), L2(2,:), L2(3,:), 'b', 'LineWidth', 4);
hPts = plot3(L2(1,:), L2(2,:), L2(3,:), 'ko', 'MarkerFaceColor','k', 'MarkerSize', 7);

% -------------------------------
% Red coordinate axes [cite: 48]
% -------------------------------
plot3([-2 2], [0 0], [0 0], 'r', 'LineWidth', 4);
plot3([0 0], [-2 2], [0 0], 'r', 'LineWidth', 4);
plot3([0 0], [0 0], [-3 3], 'r', 'LineWidth', 4);

% Axis labels
text(2.15, 0, 0, 'X-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
text(0, 2.15, 0, 'Y-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');
text(0, 0, 3.15, 'Z-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold');

% Graph settings
axis equal; axis([-2.5 2.5 -2.5 2.5 -3.5 3.5]);
grid on; box on; view(45, 25);
xlabel('X-axis'); ylabel('Y-axis'); zlabel('Z-axis');
title('3D Rotation of Vertical Line About Y-axis');

% Animation Loop [cite: 49, 50, 51]
for i = 1:length(theta)
    % Update coordinates using the Y-axis matrix
    L2 = Ry(theta(i)) * L1; 

    % Update the plot objects (Ensure these are on single lines)
    set(hLine, 'XData', L2(1,:), 'YData', L2(2,:), 'ZData', L2(3,:));
    set(hPts, 'XData', L2(1,:), 'YData', L2(2,:), 'ZData', L2(3,:));
    
    drawnow;
    pause(0.01);
end