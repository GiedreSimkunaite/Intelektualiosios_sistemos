close all
clear all
clc
% Programmed with MATLAB online 
%% % Main task 
% Multi-Layer Perceptron algorithm
% 2-layer perceptron.
% 1 hidden layer with 2 neurons with sigmoidal activation functions.
% 1 output layer has one summation neuron with linear activation function.
% Definitions
x_cnt = 22;
inner_neurons_cnt = 2;
% Perceptron input: random generater 22 parameters with values from 0 to 1
x = 0.1:1/24:1;
% Perceptron response function
pi = 3.14;
d = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x)) / 2;
figure(1)
plot(x, d);
% % Set centers, radiuses and weights
% % finding function peaks
% [y,x] = findpeaks(d);
% 
% % Centers
% cx = y;
% 
% % Radiuses
% rx = [x(1)-0.35, 0.975-x(2)];
% Create RBF centers using k-means clustering
%k = 2;  % Number of centers
%[idx, r] = kmeans(x', k);
r=[0.7667;0.3083];
cx = [0.183, 0.891];
% Calculate spread parameter (average distance to the nearest center)
rx = [0.35-0.183, 0.891-0.767 ];
% Weights of output layer neuron
wx = [0.1,0.1];%randn(1, inner_neurons_cnt);
w0 = 0.1;
% All neurons weights and biases update step
n = 0.1;
% Training cycle count
% Didinant žingsnį didėja tikslumas
epochs = 2000;%Netagli buti maziau nei 200000
cycle = 0;
% % Multi-layered perceptron training using Backpropagation algorithm
while cycle < epochs
    % Output layer summation neuron linear activation function y = y21*w21 +  y22*w22 + y23*w23 + y24*w24 + y25*w25 + y26*w26 
    y = zeros(1, 22);
    % Error array
    e = zeros(1, 22);
    for i=1:22
        % Output layer summation neuron linear activation function calculation
        for j=1:inner_neurons_cnt
            y(i) = y(i) + yx(x(i), cx(j), rx(j))*wx(j);
        end
        y(i) = y(i) + w0;
        
        % Error calculation
        e(i) = d(i) - y(i);%e(i) = 0.5 * (d(i) - y(i))^2;%
        
        %if(e(i) ~= 0)
        % Output neuron weights updates
        for j=1:inner_neurons_cnt
            wx(j) = wx(j) + n*e(i)*yx(x(i), cx(j), rx(j));
        end
        w0 = w0 + n*e(i)*1;
        %end
      
    end
    cycle = cycle + 1;
end
% % Multi-layered perceptron testing
y = zeros(1, 92);
x_test = 0.1:1/102:1;
for i=1:92
    for j=1:inner_neurons_cnt
        y(i) = y(i) + yx(x_test(i), cx(j), rx(j))*wx(j);
    end
    y(i) = y(i) + w0;
end
figure(2)
plot(x_test, y);
%% Additional task
% Weights of output layer neuron
wx = [0.1,0.1];%randn(1, inner_neurons_cnt);%[0.1,0.9]
w0 = 0.1;
cycle = 0;
cx = [0.183, 0.891];
% Calculate spread parameter (average distance to the nearest center)
rx = [0.35-0.183, 0.891-0.767 ];
% % Multi-layered perceptron training using Backpropagation algorithm
while cycle < epochs
    % Output layer summation neuron linear activation function y = y21*w21 +  y22*w22 + y23*w23 + y24*w24 + y25*w25 + y26*w26 
    y = zeros(1, 22);
    % Error array
    e = zeros(1, 22);
    for i=1:22
        % Output layer summation neuron linear activation function calculation
        for j=1:inner_neurons_cnt
            y(i) = y(i) + yx(x(i), cx(j), rx(j))*wx(j);
        end
        y(i) = y(i) + w0;
        
        % Error calculation
        e(i) = d(i) - y(i);
        
        if(e(i) ~= 0)
            % Output neuron weights updates
            for j=1:inner_neurons_cnt
                wx(j) = wx(j) + n*e(i)*yx(x(i), cx(j), rx(j));
            end
            w0 = w0 + n*e(i)*1;
            
        end
        % j_array = zeros(1,inner_neurons_cnt);
        % for j=1:inner_neurons_cnt
        %     j_array(j) = x(j)-cx(j);
        % end
        %     j_min = min(j_array);
        
        % for j = 1:inner_neurons_cnt
        % cx(j) = cx(j) - n * e * (cx(j) - x(i));
        % rx(j) = rx(j) + n * e * f(cx(j) / 3);
        % end    
        % Gauss Functions centers and radiuses updates depending on output leyer neuron weights
        %for j=1:inner_neurons_cnt
        %     if(j_min ~= j_array(j))
                %%cx(j) = cx(j) - n*j_array(j);
                y_t = yx(x(i), cx(j), rx(j));
                delta_cx = n*-e(i)*wx(j)*(y_t/rx(j)^2)*(x(i)-cx(j));%n*e(i)*y_t * w(j) * y_t / rx(j)^2 * (x(i) - cx(j));
                delta_rx = n*e(i)*wx(j)*(y_t/rx(j)) *(((x(i) - cx(j))^2/rx(j)^2)-1);
            
                % Update centers and radii
                cx(j) = cx(j) + delta_cx;
                rx(j) = rx(j) + delta_rx;
        %end
        %     %%rx(j) = rx(j) + n*e(i);
        %     % y_t = yx(x1(i), cx(j), rx(j));
        %     % delta = y_t*(1-y_t)*e(i)*wx(j);
        %     %rx(j) = rx(j) + n*e(i);%*f(cx(j));
        % end
    
    end
    cycle = cycle + 1;
end
% % Multi-layered perceptron testing
y = zeros(1, 92);
x_test = 0.1:1/102:1;
for i=1:92
    for j=1:inner_neurons_cnt
        y(i) = y(i) + yx(x_test(i), cx(j), rx(j))*wx(j);
    end
    y(i) = y(i) + w0;
end
figure(3)
plot(x_test, y);
%% Functions
% Main task: neural network output function 
% function result = f(x)
%     result = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x)) / 2;
% end
% Main task: hidden layer Gauss function y21 -> y26 
function result = yx(x, c, r)
    result = exp(-(x-c)^2/(2*r^2)); % Gauss function
end
