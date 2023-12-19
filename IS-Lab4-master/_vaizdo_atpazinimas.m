close all
clear all
clc
%% raidþiø pavyzdþiø nuskaitymas ir poþymiø skaièiavimas
%% read the image with hand-written characters
pavadinimas = 'train.jpg';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 3);
%% Atpaþintuvo kûrimas
%% Development of character recognizer

% M = cell2mat(C) converts a multidimensional cell array with contents of
%     the same data type into a single matrix. The contents of C must be able
%     to concatenate into a hyperrectangle.
P = cell2mat(pozymiai_tinklo_mokymui);

% 3 eiles, po 6 raides
T = [eye(10), eye(10), eye(10)];

% radial basis network
 % newrb(X,T,GOAL,SPREAD,MN,DF) takes these arguments,
 %     X      - RxQ matrix of Q input vectors.
 %     T      - SxQ matrix of Q target class vectors.
 %     GOAL   - Mean squared error goal, default = 0.0.
 %     SPREAD - Spread of radial basis functions, default = 1.0.
 %     MN     - Maximum number of neurons, default is Q.
 %     DF     - Number of neurons to add between displays, default = 25.
 %   and returns a new radial basis network.
tinklas = newrb(P,T,0,1,13);

%% Tinklo patikra | Test of the network (recognizer)

pavadinimas = 'test.png';
pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

%% Raidþiø atpaþinimas
%% Perform letter/symbol recognition

P2 = cell2mat(pozymiai_patikrai);

Y2 = sim(tinklas, P2);

[a2, b2] = max(Y2);
%% Rezultato atvaizdavimas
%% Visualize result

raidziu_sk = size(P2,2);

atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            % the symbol here should be the same as written first symbol in your image
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
            atsakymas = [atsakymas, 'K'];
        case 11
            atsakymas = [atsakymas, 'J'];
    end
end

disp(atsakymas)
% % % figure(7), text(0.1,0.5,atsakymas,'FontSize',38)
% %% þodþio "KADA" poþymiø iðskyrimas 
% %% Extract features of the test image
% pavadinimas = 'test.png';
% pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);
% 
% %% Raidþiø atpaþinimas
% %% Perform letter/symbol recognition
% 
% P2 = cell2mat(pozymiai_patikrai);
% 
% Y2 = sim(tinklas, P2);
% 
% [a2, b2] = max(Y2);
% %% Rezultato atvaizdavimas | Visualization of result
% 
% raidziu_sk = size(P2,2);
% 
% atsakymas = [];
% for k = 1:raidziu_sk
%     switch b2(k)
%         case 1
%             atsakymas = [atsakymas, 'A'];
%         case 2
%             atsakymas = [atsakymas, 'B'];
%         case 3
%             atsakymas = [atsakymas, 'C'];
%         case 4
%             atsakymas = [atsakymas, 'D'];
%         case 5
%             atsakymas = [atsakymas, 'E'];
%         case 6
%             atsakymas = [atsakymas, 'F'];
%         case 7
%             atsakymas = [atsakymas, 'G'];
%         case 8
%             atsakymas = [atsakymas, 'H'];
%         case 9
%             atsakymas = [atsakymas, 'I'];
%         case 10
%             atsakymas = [atsakymas, 'K'];
%         case 11
%             atsakymas = [atsakymas, 'J'];
%     end
% end
% % pateikime rezultatà komandiniame lange
% % disp(atsakymas)
% figure(8), text(0.1,0.5,atsakymas,'FontSize',38), axis off
% %% þodþio "FIKCIJA" poþymiø iðskyrimas 
% %% extract features for next/another test image
% pavadinimas = 'test1.png';
% pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);
% 
% %% Raidþiø atpaþinimas
% % poþymiai ið celiø masyvo perkeliami á matricà
% P2 = cell2mat(pozymiai_patikrai);
% % skaièiuojamas tinklo iðëjimas neþinomiems poþymiams
% Y2 = sim(tinklas, P2);
% % ieðkoma, kuriame iðëjime gauta didþiausia reikðmë
% [a2, b2] = max(Y2);
% %% Rezultato atvaizdavimas
% % apskaièiuosime raidþiø skaièiø - poþymiø P2 stulpeliø skaièiø
% raidziu_sk = size(P2,2);
% % rezultatà saugosime kintamajame 'atsakymas'
% atsakymas = [];
% for k = 1:raidziu_sk
%     switch b2(k)
%         case 1
%             atsakymas = [atsakymas, 'A'];
%         case 2
%             atsakymas = [atsakymas, 'B'];
%         case 3
%             atsakymas = [atsakymas, 'C'];
%         case 4
%             atsakymas = [atsakymas, 'D'];
%         case 5
%             atsakymas = [atsakymas, 'E'];
%         case 6
%             atsakymas = [atsakymas, 'F'];
%         case 7
%             atsakymas = [atsakymas, 'G'];
%         case 8
%             atsakymas = [atsakymas, 'H'];
%         case 9
%             atsakymas = [atsakymas, 'I'];
%         case 10
%             atsakymas = [atsakymas, 'K'];
%         case 11
%             atsakymas = [atsakymas, 'J'];
%     end
% end
% % pateikime rezultatà komandiniame lange
% % disp(atsakymas)
% figure(9), text(0.1,0.5,atsakymas,'FontSize',38), axis off
% 
