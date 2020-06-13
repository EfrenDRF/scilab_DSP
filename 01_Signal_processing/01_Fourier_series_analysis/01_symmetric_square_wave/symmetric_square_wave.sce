/*
 * 
 * Author: Efren Del Real Frias
 * File_name: symmetric_square_wave.sce
 * Date: June 13th 2020
 * Software tool: scilab 6.0.2
 * Description: Displays the graphical representation of trigonometric Fourier 
 *              series. 
 *              Using  coefficients have already calculated of square wave.
 * 
 */

clc();
clear();

/*------------------------------------------------------------------*/
/*Wave parameters                                                   */
/*------------------------------------------------------------------*/
DUTY_CYCLE = 1
PERIOD = 5
AMPLITUDE = 1
N_HARMONIC = 50 /*Max number of harmonic to analyze from 1 to ...*/
N_MAX_CYCLES = 3  /*Max number of cycles to graph from 1 to ...*/

/*------------------------------------------------------------------*/
/*                                                                  */
/*------------------------------------------------------------------*/
if  (DUTY_CYCLE > PERIOD) then
     messagebox("DUTY_CYCLE should be less than PERIOD value", "Error", "error")
else
    tau = DUTY_CYCLE;
    T = PERIOD;
    A = AMPLITUDE
    w0 = (2*%pi)/T;
    
    /* Fourier a_0 coefficient */
    a0_coefficient = (2*A*tau)/T;
    
    /* Fourier a_n coefficient */
    function [an_coefficient]=fGet_an_coefficient(n_harmonic)
        an_coefficient = ((2*A*tau)/(T))*sinc((n_harmonic*%pi*tau)/(T));
    endfunction
    
    /* Fourier b_n coefficient*/
    // bn_coefficient = 0; 
    
    
    /* Vector time */
    t = (-(N_MAX_CYCLES/2):0.01:(N_MAX_CYCLES/2))*T;
    
    /* Vector of coefficients a_n*/
    an_vector = zeros(1,N_HARMONIC);
    
    /*Calculates the trigonometric Fourier series-------------------------*/
    f_t = (a0_coefficient/2);
    for n = 1:N_HARMONIC
        an_vector(1,n) = fGet_an_coefficient(n)
        f_t = f_t + an_vector(1,n)*cos(n*w0*t);
    end
    
    
    /*Display------------------------------------------------*/
    clf();
    subplot(2,1,1);
        plot(t,f_t,'LineWidth',3)
        xtitle('Graphical representation of Fouriel seires','t','f(t)');
    subplot(2,1,2);
        a=gca();
        a.thickness = 3;
        plot2d3(an_vector)
        xtitle('Graphical representation of Fourier coefficient a_n','n','a[n]');
    
end
   

