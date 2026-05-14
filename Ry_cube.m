clc; clear; close all

% 1. Rotation matrix about Y-axis
Ry = @(theta) [cos(theta)  0  sin(theta)
               0           1  0
               -sin(theta) 0  cos(theta)];

% Cube points: Each column is one point [x; y; z]
C = [1  2  2  1  1  2  2  1
     1  1  2  2  1  1  2  2
     1  1  1  1  2  2  2  2];

% Cube edges using point numbers
edges = [1 2; 2 3; 3 4; 4 1; 5 6; 6 7; 7 8; 8 5; 1 5; 2 6; 3 7; 4 8];

% Cube faces for transparent surface
faces = [1 2 3 4; 5 6 7 8; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8];

theta = 0:0.03:10*pi;

figure('Color','w')
hold on

% 2. Initial cube position using Ry
C2 = Ry(theta(1)) * C;

% Transparent cube faces
hCube = patch('Vertices', C2', ...
              'Faces', faces, ...
              'FaceColor', 'cyan', ...
              'FaceAlpha', 0.25, ...
              'EdgeColor', 'none');

% Cube edges
hEdges = gobjects(size(edges,1),1);
for k = 1:size(edges,1)
    p1 = edges(k,1);
    p2 = edges(k,2);
    hEdges(k) = plot3([C2(1,p1) C2(1,p2)], ...
                      [C2(2,p1) C2(2,p2)], ...
                      [C2(3,p1) C2(3,p2)], ...
                      'b', 'LineWidth', 3);
end

% Cube points
hPts = plot3(C2(1,:), C2(2,:), C2(3,:), 'ko', ...
             'MarkerFaceColor', 'k', ...
             'MarkerSize', 6);

% Point labels
hLabels = gobjects(8,1);
for k = 1:8
    hLabels(k) = text(C2(1,k), C2(2,k), C2(3,k), ...
                      ['  P' num2str(k)], ...
                      'FontSize', 10, ...
                      'FontWeight', 'bold');
end

% -------------------------------------------------
% Bold red coordinate axes
% -------------------------------------------------
plot3([-4 4], [0 0], [0 0], 'r', 'LineWidth', 4); text(4.2, 0, 0, 'X-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold')
plot3([0 0], [-4 4], [0 0], 'r', 'LineWidth', 4); text(0, 4.2, 0, 'Y-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold')
plot3([0 0], [0 0], [-4 4], 'r', 'LineWidth', 4); text(0, 0, 4.2, 'Z-axis', 'Color', 'r', 'FontSize', 12, 'FontWeight', 'bold')

% 3. Circular guide paths for Y-axis rotation (X-Z plane)
t = linspace(0, 2*pi, 300);
for k = 1:8
    r = sqrt(C(1,k)^2 + C(3,k)^2); % Radius in the X-Z plane
    % Path rotates in X and Z, Y remains constant
    plot3(r*cos(t), C(2,k)*ones(size(t)), r*sin(t), 'k--', 'LineWidth', 1)
end

% Graph setting
axis equal
axis([-4 4 -4 4 -4 4])
grid on
box on

xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')
title('3D Cube Rotation About Y-axis')

view(45, 25)
camproj perspective

% 4. Animation loop using Ry
for i = 1:length(theta)
    % Update points using Y-axis rotation
    C2 = Ry(theta(i)) * C;

    % Update graphics objects
    set(hCube, 'Vertices', C2')
    for k = 1:size(edges,1)
        p1 = edges(k,1); p2 = edges(k,2);
        set(hEdges(k), 'XData', [C2(1,p1) C2(1,p2)], ...
                       'YData', [C2(2,p1) C2(2,p2)], ...
                       'ZData', [C2(3,p1) C2(3,p2)]);
    end
    set(hPts, 'XData', C2(1,:), 'YData', C2(2,:), 'ZData', C2(3,:));
    for k = 1:8
        set(hLabels(k), 'Position', [C2(1,k), C2(2,k), C2(3,k)]);
    end

    drawnow
    pause(0.02)
end