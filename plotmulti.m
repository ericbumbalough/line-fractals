function [  ] = plotmulti( in, color )
%plots frac data files

%frac data file are 

if nargin == 1; color = 'black'; end;

hold on
for j = 1:size(in,2)
    for i = 1:size(in{j},3)
        plot(in{j}(:,1,i),in{j}(:,2,i),'Color', color)
    end
end
end

