/*
 * 
 * Author: Efren Del Real Frias
 * File_name: sigConv_1.sce
 * Date: June 26th 2020
 * Software tool: scilab 6.0.2
 * Description: Graph of convolution function. Obtained it from two time signals
 * Analytical analysis: https://es.overleaf.com/read/xsmxgfbwzqgc
 */

clc();
clear();
/* Constant Definition -----------------------------------------------------*/
NUM_SAMPLES = 500;

MAX_TIME = 4;
MIN_TIME = -4;

/* Time --------------------------------------------------------------------*/
/* Samples differential */
ds = ((MAX_TIME-MIN_TIME)/NUM_SAMPLES);

/* Vector time */
t = (MIN_TIME : ds: (MAX_TIME-ds) );
    
/*Signals Definition--------------------------------------------------------*/
x = zeros(1,NUM_SAMPLES)
h =zeros(1,NUM_SAMPLES)

for dt=1:length(t)
    /*Builds signal_1 _____________________________________*/
    if((t(dt) >= 0) && (t(dt) <= 1))
        x(dt) = 1;
    end
    
    /*Builds signal_2 ____________________________________*/
    if((t(dt) >= 0) && (t(dt) <= 1))
        h(dt) = 1;
    elseif ((t(dt) > 1) && (t(dt) <= 2))
        h(dt) = 2;
    end
    
end


/* Function Definition -------------------------------------------------------*/
function [convSignal] = fConvolution(vecSignal_1, vecSignal_2)
    
    /*Local variables definition**************/
    vLen = length(vecSignal_1);
    vIntegration = 0;
    vStartIndex = 0;
    
    /*Local vector definition****************/
    convSignal = zeros(1,vLen);
    
    for vStartIndex = 1: vLen
        if(vecSignal_1(vStartIndex) <> 0)
            break;
        end
    end
    
    
    for i = 1: vLen
        for j=1:i
            if((i-j+ vStartIndex) <= vLen)
                vIntegration = vIntegration + vecSignal_1((i-j+ vStartIndex))*vecSignal_2(j);
            end
        end /* End for j*/
            
        convSignal(i) = vIntegration*ds;
        vIntegration = 0;

    end /* End for i */
    
endfunction

/*Gets convolution from x(t) * h(t) */
y = fConvolution( x, h);


/*Display --------------------------------------------------------------------*/
clf();
    subplot(3,1,1);
        plot(t,x,'LineWidth',3)
        xlabel("t","fontsize",2)
        ylabel("x(t)","fontsize", 5);
    subplot(3,1,2);
        plot(t,h,'LineWidth',3)
        xlabel("t","fontsize",2)
        ylabel("h(t)","fontsize", 5);
    subplot(3,1,3);
        plot(t,y,'LineWidth',3)
        xlabel("t","fontsize",2)
        ylabel("y(t)","fontsize", 5);
