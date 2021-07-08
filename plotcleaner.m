% plot maker: cleans up plot
set(gcf, 'PaperType','tabloid')
set(gca,'XTick',[],'YTick',[],'Xcolor','w','Ycolor','w')
axis tight
set(gca,'ylim',1.01*get(gca,'ylim'))
set(gca,'xlim',1.01*get(gca,'xlim'))