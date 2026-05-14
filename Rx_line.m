clc; clear; close all

% 1. Rotation matrix about x-axis
Rx = @(theta) [ 1    0            0 
                0 cos(theta) -sin(theta) 
                0 sin(theta)  cos(theta) ];

% 2. Vertical line from (1,1,1) to (1,1,2)
L1 = [1  1
      1  1
      1  2];

theta = 0:0.03:10*pi;

figure('Color','w')
hold on

% Initial position of rotating vertical line
L2 = Rx(theta(1)) * L1;

% Plot rotating vertical line
hLine = plot3(L2(1,:), L2(2,:), L2(3,:), 'b', 'LineWidth', 4);

% Plot end points of vertical line
hPts = plot3(L2(1,:), L2(2,:), L2(3,:), 'ko', ...
             'MarkerFaceColor','k', 'MarkerSize', 7);

% -------------------------------
% Bold red coordinate axes
% -------------------------------
plot3([-2 2], [0 0], [0 0], 'r', 'LineWidth', 4)
plot3([0 0], [-2 2], [0 0], 'r', 'LineWidth', 4)
plot3([0 0], [0 0], [-3 3], 'r', 'LineWidth', 4)

% Axis labels
text(2.15, 0, 0, 'X-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold')
text(0, 2.15, 0, 'Y-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold')
text(0, 0, 3.15, 'Z-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold')

% Graph settings
axis equal
axis([-2.5 2.5 -2.5 2.5 -3.5 3.5])
grid on
box on

xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
title('3D Rotation of Vertical Line About X-axis')

view(45, 25)
camproj perspective

% Animation Loop
for i = 1:length(theta)
    % Rotate vertical line about x-axis
    L2 = Rx(theta(i)) * L1;

    % Update rotating vertical line
    set(hLine, 'XData', L2(1,:), 'YData', L2(2,:), 'ZData', L2(3,:));
    
    % Update end points
    set(hPts, 'XData', L2(1,:), 'YData', L2(2,:), 'ZData', L2(3,:));
    
    drawnow
    pause(0.02)
end
