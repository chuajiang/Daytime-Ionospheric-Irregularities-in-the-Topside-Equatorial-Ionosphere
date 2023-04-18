load('simulation_data.mat');
load('vik.mat');
nx=201;
nz=401;
figure(1); 
figure(2);
figindex=1;
itindex=1;
for i=1:6

    NE_tmp=reshape(simulation_data.Ne(i,:,:),nx,nz);
    hp_tmp=reshape(simulation_data.hp(i,:,:),nx,nz);
    op_tmp=reshape(simulation_data.op(i,:,:),nx,nz);
    nop_tmp=reshape(simulation_data.nop(i,:,:),nx,nz);
    o2p_tmp=reshape(simulation_data.o2p(i,:,:),nx,nz);
    hep_tmp=reshape(simulation_data.hep(i,:,:),nx,nz);
    n2p_tmp=reshape(simulation_data.n2p(i,:,:),nx,nz);
    np_tmp=reshape(simulation_data.np(i,:,:),nx,nz);

%     figure;
    strtitle=sprintf('t=%ds',simulation_data.it(i)*100*0.5);
    figure(1);
    subplot(2,3,figindex);
    datatmp=reshape(NE_tmp(:,:),nx,nz);
    if figindex>1
        datatmp=reshape(NE_tmp(:,:),nx,nz)./1e6; 
    end
      
    contourf((0:nx-1)*2,200+(0:nz-1)*2,log10(datatmp'),'LevelStep',0.1);
    colormap(vik);
    colorbar;
    caxis([3.0 6.0]);
    axis([0 (nx-1)*2 200 800]);
    title(strtitle);

    set(gca,'FontName','Helvetica', 'FontSize',14,'fontweight','bold' );
    ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    xlabel('Zonal distance (km)','FontSize',14,'fontweight','bold');

    figure(2)
    subplot(2,3,figindex);
    xindex=100;
    ep=[hp_tmp(xindex,:)+op_tmp(xindex,:)+nop_tmp(xindex,:)+o2p_tmp(xindex,:)+hep_tmp(xindex,:)+n2p_tmp(xindex,:)+np_tmp(xindex,:)];
    ionp=[hp_tmp(xindex,:);op_tmp(xindex,:);nop_tmp(xindex,:);o2p_tmp(xindex,:);hep_tmp(xindex,:);n2p_tmp(xindex,:);np_tmp(xindex,:);ep];
    lcolor = colormap(jet(8));
    for pindex=1:8
        plot(log10(ionp(pindex,:)),200+(0:nz-1)*2,'linewidth',2,'color',lcolor(pindex,:));hold on;
    end
    
    axis([0 10 200 800]);
    legend('h^+','o^+','no^+','o_2^+','he^+','n_2^+','n^+','e');
    title(strtitle);
    set(gca,'FontName','Helvetica', 'FontSize',14,'fontweight','bold' );
    ylabel('Altitude (km)','FontSize',14,'fontweight','bold');
    xlabel('Density (Log10(N(cm^-^3)))','FontSize',14,'fontweight','bold');
    figindex=figindex+1;

    pause(1);
    
end