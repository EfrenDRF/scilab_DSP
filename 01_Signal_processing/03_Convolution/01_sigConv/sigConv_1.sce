/*
 * 
 * Author: Efren Del Real Frias
 * File_name: sigConv_1.sce
 * Date: June 24th 2020
 * Software tool: scilab 6.0.2
 * Description: 
 * 
 * Analytical analysis: 
 */

clc();
clear();
/* Constant Definition -----------------------------------------------------*/
NUM_SAMPLES = 500;

MAX_TIME = 3;
MIN_TIME = 0;

/* Time --------------------------------------------------------------------*/
/* Samples differential */
ds = ((MAX_TIME-MIN_TIME)/NUM_SAMPLES);

/* Vector time */
t = (MIN_TIME : ds: (MAX_TIME-ds) );
    
/*Signals Definition--------------------------------------------------------*/
x = zeros(1,NUM_SAMPLES)
h =zeros(1,NUM_SAMPLES)

for dt=1:length(t)
    /*Builds signal_1 *********************************/
    if((t(dt) >= 0) && (t(dt) <= 1))
        x(dt) = 1;
    end
    
    /*Builds signal_2 ******************************/
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
    
    /*Local vector definition****************/
    convSignal = zeros(1,vLen);
    
    for i = 1: vLen
        for j=1:i
         vIntegration = vIntegration + vecSignal_1((i-j+1))*vecSignal_2(j);
        end
        convSignal(i) = vIntegration*ds;
        vIntegration = 0;
    end
endfunction


y = fConvolution( x, h);


/*Display --------------------------------------------------------------------*/
clf();
    subplot(3,1,1);
        plot(t,x,'LineWidth',3)
    subplot(3,1,2);
        plot(t,h,'LineWidth',3)
    subplot(3,1,3);
        plot(t,y,'LineWidth',3)
