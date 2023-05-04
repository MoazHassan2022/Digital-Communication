function [] = subplotOutput(time, output, samplingPoints, filterName, index, color, shape)
    subplot(3,1,index);
    plot(time, output, color, samplingPoints, output(samplingPoints), shape);
    xlabel('Time');
    ylabel('Output');
    title(strcat('Output After ', filterName)); 
end