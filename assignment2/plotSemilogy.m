function [] = plotSemilogy(eNoDB, theoryBER, simBER, filterName)
    semilogy(eNoDB,theoryBER,'','Linewidth',1);
    hold on
    semilogy(eNoDB,simBER,'','Linewidth',1);
    axis([-10 20 10^-5 0.5])
    grid on
    %legend('Theoretical', 'Simulated');
    xlabel('Eb/No, dB');
    ylabel('Bit Error Rate');
    title(strcat('Bit Error Rate for', ' ', filterName));
end