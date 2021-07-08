function [] = fracplot(in)
%plots a fractal output data cell
hold on
for i = 1:size(in,1)
    for j = 1:size(in{i},2)
        for k = 1:size(in{i}{j},3)
            plot(in{i}{j}(:,1,k),in{i}{j}(:,2,k))
            pause
        end
    end
end
end