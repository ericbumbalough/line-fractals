function [ out ] = linefrac( new, n )
%LINEFRAC creates a fractal by replacing every line with the line segments
%contained in new with n iterations

%% Inputs
%new: Points to generate fractal. A 1 by k cell. Each element of the cell
    %is a m by 2 matrix of form [x1 y1;x2 y2;...xm ym]. Each m for
    %different cell elements do not need to be the same.
    
%n: Number of iterations

%% Outputs
%out: Fractal output. A 1 by n cell where each element represents and
    %iteration. out{i} is the i'th iteration.
    %out{i} is a 1 by k cell. Each element is a m by 2 by r matrix. 
    
%% Initialization
out = cell(n,1);

out{1} = new;

%% Calculation
for i = 2:n %iteration loop
    for cellloop = 1:size(out{i-1},2) %cell loop
        for k = 1:size(out{i-1}{cellloop},3)%outer vector loop
            delta = diff(out{i-1}{cellloop}(:,:,k),1,1); %difference in points
            quadII = (delta(:,1) < 0) & (delta(:,2) > 0); %points in quadrant 2
            quadIII = (delta(:,1) < 0) & (delta(:,2) <= 0); %points in quadrant 3
            
            rotangle = atan(delta(:,2)./abs(delta(:,1))); %principle value for atan
            rotangle(quadII) = pi - rotangle(quadII); %overwrite values in other quadrants
            rotangle(quadIII) = -pi - rotangle(quadIII);
            
            R = cat(1,permute([cos(rotangle),-sin(rotangle)],[3,2,1]),permute([sin(rotangle),cos(rotangle)],[3,2,1]));%rotation matrix
            l = sqrt(delta(:,1).^2+delta(:,2).^2); %length
            
            for j = 1:size(out{i-1}{cellloop},1)-1 %inner vector loop
                for crossloop = 1:size(out{i-1},2) %cell loop
                    t = j+cellsize(crossloop)*(k-1)+max(sum(cellsize(1:cellloop-1)),0);
                    out{i}{crossloop}(:,:,t) = (l(j)*R(:,:,j)*new{crossloop}')';%rotate and scale
                    out{i}{crossloop}(:,1,t) = out{i}{crossloop}(:,1,t) + out{i-1}{cellloop}(j,1,k); %translate
                    out{i}{crossloop}(:,2,t) = out{i}{crossloop}(:,2,t) + out{i-1}{cellloop}(j,2,k);
                end
            end
        end
    end
end


end

