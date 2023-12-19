close all
clear all
clc

% ABC_TRAIN.png and ABC_TEST.png images are scanned hand-written characters

% % % Main task

%% Read the image with hand-written characters
pavadinimas = 'ABC_TRAIN.png';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 6);

%% Development of character recognizer
% Take the features from cell-type variable and save into a matrix-type variable
% Radial-Basis function neural network input matrix
P = cell2mat(pozymiai_tinklo_mokymui);

% Radial-Basis function (RBF) neural network target matrix 10x60
% eye(10) - identity matrix (vienetine matrica) 10x10
% eye(nr) count equals image symbol rows count, 'nr' is number of symbols in one row. 
T = [eye(10), eye(10), eye(10), eye(10), eye(10), eye(10)];

% Create an RBF network for classification with 10 neurons, and sigma = 1
neurons = 10; % 13 % neurons count
tinklas = newrb(P,T,0,1,neurons);

%% Test of the RBF network (recognizer)
% Estimate output of the network for unknown symbols (row, that were not used during training)
P2 = P(:,12:22);

% Simulink simulation of a neural network
Y2 = sim(tinklas, P2);

% Find which neural network output gives maximum value
[a2, b2] = max(Y2);

%% Display result
% calculate the total number of symbols in the row (P2 column values count)
raidziu_sk = size(P2,2); % finds size of P2 second column

% Save the result in variable 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            % The symbol here should be the same as written first symbol in your image
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'D'];
        case 5
            atsakymas = [atsakymas, 'E'];
        case 6
            atsakymas = [atsakymas, 'F'];
        case 7
            atsakymas = [atsakymas, 'G'];
        case 8
            atsakymas = [atsakymas, 'H'];
        case 9
            atsakymas = [atsakymas, 'I'];
        case 10
            atsakymas = [atsakymas, 'J'];
        % case 11
        %     atsakymas = [atsakymas, 'K'];
        % case 10
        %     atsakymas = [atsakymas, 'K'];
        % case 11
        %     atsakymas = [atsakymas, 'J'];
    end
end

% Show the result in command window
disp(atsakymas)
figure(7), text(0.1,0.5,atsakymas,'FontSize',38)

%% Extract features of the test image
pavadinimas = 'ABC_TEST.png';
pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

%% Perform letter recognition

% features from cell-variable are stored to matrix-variable
P2 = cell2mat(pozymiai_patikrai);

% estimating neuran network output for newly estimated features
Y2 = sim(tinklas, P2);

% searching which output gives maximum value
[a2, b2] = max(Y2);
%% Display result
% calculating number of symbols - number of columns
raidziu_sk = size(P2,2);
% Save result in 'atsakymas' variable
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'D'];
        case 5
            atsakymas = [atsakymas, 'E'];
        case 6
            atsakymas = [atsakymas, 'F'];
        case 7
            atsakymas = [atsakymas, 'G'];
        case 8
            atsakymas = [atsakymas, 'H'];
        case 9
            atsakymas = [atsakymas, 'I'];
        case 10
            atsakymas = [atsakymas, 'J'];
        % case 11
        %     atsakymas = [atsakymas, 'K'];
        % case 10
        %     atsakymas = [atsakymas, 'K'];
        % case 11
        %     atsakymas = [atsakymas, 'J'];
    end
end
% pateikime rezultatà komandiniame lange
% disp(atsakymas)
figure(8), text(0.1,0.5,atsakymas,'FontSize',38), axis off

% % % Additional Task

%% Read the image with hand-written characters
pavadinimas = 'ABC_TRAIN.png';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 6);

%% Development of character recognizer
% Take the features from cell-type variable and save into a matrix-type variable
% Feed-forward backpropagation neural network input matrix
P = cell2mat(pozymiai_tinklo_mokymui);

% Neural network target matrix 10x60
% eye(10) - identity matrix (vienetine matrica) 10x10
% eye(nr) count equals image symbol rows count, 'nr' is number of symbols in one row. 
T = [eye(10), eye(10), eye(10), eye(10), eye(10), eye(10)];

% Create an RBF network for classification with 13 neurons, and sigma = 1
hidden_neurons = 10; % 13 % neurons count
tinklas = newff(P,T,hidden_neurons);

%% Test of the RBF network (recognizer)

% Set up training parameters
tinklas.trainParam.epochs = 10000; % Number of training epochs
tinklas.trainParam.lr = 0.001; % Learning rate
tinklas.trainParam.goal = 1e-10; % Training goal (error threshold)

% Train the neural network
tinklas = train(tinklas, P, T);

% Estimate output of the network for unknown symbols (row, that were not used during training)
P2 = P(:,12:22);
Y2 = sim(tinklas, P2);

% Find which neural network output gives maximum value
[a2, b2] = max(Y2);

%% Display result
% calculate the total number of symbols in the row (P2 column values count)
raidziu_sk = size(P2,2);

% Save the result in variable 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            % The symbol here should be the same as written first symbol in your image
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'D'];
        case 5
            atsakymas = [atsakymas, 'E'];
        case 6
            atsakymas = [atsakymas, 'F'];
        case 7
            atsakymas = [atsakymas, 'G'];
        case 8
            atsakymas = [atsakymas, 'H'];
        case 9
            atsakymas = [atsakymas, 'I'];
        case 10
            atsakymas = [atsakymas, 'J'];
        % case 11
        %     atsakymas = [atsakymas, 'K'];
        % case 10
        %     atsakymas = [atsakymas, 'K'];
        % case 11
        %     atsakymas = [atsakymas, 'J'];
    end
end

% Show the result in command window
disp(atsakymas)
figure(9), text(0.1,0.5,atsakymas,'FontSize',38)

%% extract features for next/another test image
pavadinimas = 'ABC_TEST.png';
pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

%% Character recognition
% Take the features from cell-type variable and save into a matrix-type variable
P2 = cell2mat(pozymiai_patikrai);
% skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
Y2 = sim(tinklas, P2);
% ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
[a2, b2] = max(Y2);
%% Rezultato atvaizdavimas
% calculate the total number of symbols in the row (P2 column values count)
raidziu_sk = size(P2,2);
% Save result in 'atsakymas' variable
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'D'];
        case 5
            atsakymas = [atsakymas, 'E'];
        case 6
            atsakymas = [atsakymas, 'F'];
        case 7
            atsakymas = [atsakymas, 'G'];
        case 8
            atsakymas = [atsakymas, 'H'];
        case 9
            atsakymas = [atsakymas, 'I'];
        case 10
            atsakymas = [atsakymas, 'J'];
    end
end
% pateikime rezultatà komandiniame lange
% disp(atsakymas)
figure(10), text(0.1,0.5,atsakymas,'FontSize',38), axis off

