function [ out ] = frac( new, init, n )
%new is a {1xr} cell full of other 1 dimensional cells. It must be oriented
%along x axis
% hold on
set(gca,'XTick',[],'YTick',[],'Xcolor','w','Ycolor','w')

out = cell(n,1);

% ind = newplot; %individual step plot
% cum = newplot; %cumulative plot

for q = 1:size(new,2)
    out{1}{q} = ([0 -1;1 0]*new{q}')'; %first iteration is rotation to vertical
    cellsize(q) = size(out{1}{q},1);
%      plotmulti(out{1});
%      pause
%     plotmulti(cum,out{1}{q});
end

 %set(gcf,'NextPlot','new')

for i = 2:n %iteration loop
    for cellloop = 1:size(out{i-1},2) %cell loop
        for k = 1:size(out{i-1}{cellloop},3)%outer vector loop
            delta = diff(out{i-1}{cellloop}(:,:,k),1,1); %difference in points
            quadII = (delta(:,1) < 0) & (delta(:,2) > 0); %points in quadrant 2
            quadIII = (delta(:,1) < 0) & (delta(:,2) <= 0); %points in quadrant 3
            
            rotangle = atan(delta(:,2)./abs(delta(:,1))); %principle value for atan
            rotangle(quadII) = pi - rotangle(quadII);%overwrite values in other quadrants
            rotangle(quadIII) = -pi - rotangle(quadIII);
            
            R = cat(1,permute([cos(rotangle),-sin(rotangle)],[3,2,1]),permute([sin(rotangle),cos(rotangle)],[3,2,1]));%rotation matrix
            l = sqrt(delta(:,1).^2+delta(:,2).^2); %length
            
            for j = 1:size(out{i-1}{cellloop},1)-1 %vector loop
                for crossloop = 1:size(out{i-1},2) %cell loop
                    t = j+cellsize(crossloop)*(k-1)+max(sum(cellsize(1:cellloop-1)),0);
                    %                     i
                    %                     cellloop
                    %                     k
                    %                     j
                    %                     crossloop
                    %                     [i crossloop t]
                    %                     try
                    %                         out{i}{crossloop}(:,:,t)
                    %                     catch
                    %                         a = 'ok'
                    %                     end
                    
                    out{i}{crossloop}(:,:,t) = (l(j)*R(:,:,j)*new{crossloop}')';%rotate and scale
                    out{i}{crossloop}(:,1,t) = out{i}{crossloop}(:,1,t) + out{i-1}{cellloop}(j,1,k); %translate
                    out{i}{crossloop}(:,2,t) = out{i}{crossloop}(:,2,t) + out{i-1}{cellloop}(j,2,k);
                    
                    %                     plotmulti(out{i}{crossloop}(:,:,j+cellsize(crossloop)*(k-1)),'red')
%                      plotmulti(out{i});
%                      pause
                end
            end
        end
    end
end


end

