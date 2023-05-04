function [] = plotThreeOutputs(time, outputMatched, outputDelta, outputTri, samplingPoints)
    figure;
    subplotOutput(time, outputMatched, samplingPoints, 'Matched Filter', 1, 'b-', 'ro');
    subplotOutput(time, outputDelta, samplingPoints, 'Delta Filter', 2, 'k-', 'bs');
    subplotOutput(time, outputTri, samplingPoints, 'Triangle Filter', 3, 'r-', 'gd');
    suptitle('Outputs After the Three Filters'); 
end