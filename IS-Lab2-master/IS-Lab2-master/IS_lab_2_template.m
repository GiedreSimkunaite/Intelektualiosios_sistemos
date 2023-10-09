clear all
clc

% Programmed with MATLAB online 

%% % Main task 
% Multi-Layer Perceptron algorithm
% 2-layer perceptron.
% 1 hidden layer with 6 neurons with sigmoidal activation functions.
% 1 output layer has one summation neuron with linear activation function.

% Perceptron input: random generater 22 parameters with values from 0 to 1
x1 = sort(rand(1, 22), 'ascend');

% Perceptron response function
pi = 3.14;
d = (1 + 0.6*sin(2*pi*x1/0.7) + 0.3*sin(2*pi*x1)) / 2;

figure(1)
plot(d, x1);

% % Set weights and biases

% Weights of hidden layer neurons w11 = w1x(1) -> w16 = w1x(6)
w1x = randn(1, 6);

% Biases of hidden layer neurons b11 = b1x(1) -> b16 = b1x(6)
b1x = randn(1, 6);

% Weights of output layer neuron w21 = w2x(1) -> w26 = w2x(6)
w2x = randn(1, 6);

% Biase of output layer neuron
b21 = randn(1);

% All neurons weights and biases update step
n = 0.1;

% Training cycle count
% Didinant žingsnį didėja tikslumas
epochs = 200000;

cycle = 0;

% % Multi-layered perceptron training using Backpropagation algorithm
while cycle < epochs

    % Output layer summation neuron linear activation function y = y21*w21 +  y22*w22 + y23*w23 + y24*w24 + y25*w25 + y26*w26 
    y = zeros(1, 22);

    % Error array
    e = zeros(1, 22);

    for i=1:22

        % Output layer summation neuron linear activation function calculation
        for j=1:6
            v = v1x(w1x(j), x1(i), b1x(j));
            y(i) = y(i) + y2x(v)*w2x(j);
        end
        y(i) = y(i) + b21;

        % Error calculation
        e(i) = d(i) - y(i);
        
        % Output neuron weights and bias updates
        for j=1:6
            v = v1x(w1x(j), x1(i), b1x(j));
            w2x(j) = w2x(j) + n*e(i)*y2x(v);
        end

        b21 = b21 + n*e(i)*1;
    
        % Hidden neurons weights and biases updates depending on output leyer neuron weights
        for j=1:6
            v = v1x(w1x(j), x1(i), b1x(j));
            delta = y2x(v)*(1-y2x(v))*e(i)*w2x(j);
            w1x(j) = w1x(j) + n*delta*x1(i);
            b1x(j) = b1x(j) + n*delta;
        end
    
    end

    cycle = cycle + 1;
end

% % Multi-layered perceptron testing
y = zeros(1, 22);

for i=1:22
    for j=1:6
        v = v1x(w1x(j), x1(i), b1x(j));
        y(i) = y(i) + y2x(v)*w2x(j);
    end
    y(i) = y(i) + b21;
end

figure(2)
plot(y, x1);

%% Additional task
% Same as main task, except Perceptron has two inputs

% Perceptron input: random generater 22 parameters with values from 0 to 1
x2 = sort(rand(1, 22), 'ascend');

% Perceptron response function
d = (1 + 0.6*sin(2*pi*x1/0.7) + 0.3*sin(2*pi*x2)) / 2;

figure(3)
plot(d, x1);

% Weights of hidden layer neurons w111 = w11x(1) -> w116 = w11x(6)
w11x = randn(1, 6);

% Weights of hidden layer neurons w121 = w12x(1) -> w126 = w12x(6)
w12x = randn(1, 6);

% Biases of hidden layer neurons b11 = b1x(1) -> b16 = b1x(6)
b1x = randn(1, 6);

% Weights of output layer neuron w21 = w2x(1) -> w26 = w2x(6)
w2x = randn(1, 6);

% Biase of output layer neuron
b21 = randn(1);

cycle = 0;

% % Multi-layered perceptron training using Backpropagation algorithm
while cycle < epochs

    % Output layer summation neuron linear activation function y = y21*w21 +  y22*w22 + y23*w23 + y24*w24 + y25*w25 + y26*w26 
    y = zeros(1, 22);

    % Error array
    e = zeros(1, 22);

    for i=1:22

        % Output layer summation neuron linear activation function calculation
        for j=1:6
            v = Av1x(w11x(j), x1(i), w12x(j), x2(i), b1x(j));
            y(i) = y(i) + y2x(v)*w2x(j);
        end
        y(i) = y(i) + b21;

        % Error calculation
        e(i) = d(i) - y(i);
        
        % Output neuron weights and bias updates
        for j=1:6
            v = Av1x(w11x(j), x1(i), w12x(j), x2(i), b1x(j));
            w2x(j) = w2x(j) + n*e(i)*y2x(v);
        end

        b21 = b21 + n*e(i)*1;
    
        % Hidden neurons weights and biases updates depending on output leyer neuron weights
        for j=1:6
            v = Av1x(w11x(j), x1(i), w12x(j), x2(i), b1x(j));
            delta = y2x(v)*(1-y2x(v))*e(i)*w2x(j);
            w11x(j) = w11x(j) + n*delta*x1(i);
            w12x(j) = w12x(j) + n*delta*x2(i);
            b1x(j) = b1x(j) + n*delta;
        end
    
    end

    cycle = cycle + 1;
end

% % Multi-layered perceptron testing
y = zeros(1, 22);

for i=1:22
    for j=1:6
        v = Av1x(w11x(j), x1(i), w12x(j), x2(i), b1x(j));
        y(i) = y(i) + y2x(v)*w2x(j);
    end
    y(i) = y(i) + b21;
end

figure(4)
plot(y, x1);

%% Functions
% Main task: hidden layer neurons input function v11 -> v16 
function result = v1x(w1x, x1, b1x)
    result = x1*w1x + b1x;
end

% Main task: hidden layer neurons activation function y21 -> y26 
function result = y2x(v1x)
    result = 1 / (1 + exp((-1)*v1x));
end

% Additional task: hidden layer neurons input function v11 -> v16 
function result = Av1x(w11x, x1, w12x, x2, b1x)
    result = x1*w11x + x2*w12x + b1x;
end


