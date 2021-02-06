clc
clear
close all

nx = 50;
ny = 50;
V = zeros(nx,ny);

iterations = 100;
mode = 1;

if mode == 0
    BC_left = 1; BC_right = 0;
    V(:,1) = BC_left; V(:,end) = BC_right;    
elseif mode == 1
    BC_left = 1; BC_right = 1; BC_top = 0; BC_bottom = 0;
    V(:,1) = BC_left; V(:,end) = BC_right; V(1,:) = BC_top; V(end,:) = BC_bottom;
else
    BC_left = 1; BC_right = 0; BC_top = 0; BC_bottom = 0;
    V(:,1) = BC_left; V(:,end) = BC_right; V(1,:) = BC_top; V(end,:) = BC_bottom;
end

for i=1:iterations
    for n=2:length(V)-1
        for m=2:length(V)-1
            V(n,m) = ( V(n,m+1) + V(n,m-1) + V(n-1,m) + V(n+1,m) ) / 4;
        end
    end
    if mode == 0
        V(1,:) = V(2,:);
        V(end,:) = V(end-1,:);
    end
    surf(V)
    view(0,90)
    colorbar
    drawnow limitrate
    pause(0.01);
end

[Ex,Ey] = gradient(V);
figure;
quiver(-Ex,-Ey,5);