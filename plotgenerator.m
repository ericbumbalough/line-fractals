% clear
% data = open('r4n5z26 diamond fractal.mat')

% color = [0 .5 .75 ];
% width = [ 3 1.5 .75];
clf
hold on

out2 = out;

for c = 1:length(out)
    
    out2{c} = [-flipud(out{c}(2:end,1)), flipud(out{c}(2:end,2)); out{c}];
    plot(out2{c}(:,1),out2{c}(:,2),'Color',[0,0,0])%,'Color',color(c)*[1 1 1],'LineWidth',width(c))
    plot(out2{c}(:,1),-out2{c}(:,2),'Color',[0,0,0])%,'Color',color(c)*[1 1 1],'LineWidth',width(c))
    clear out2
end

plotcleaner