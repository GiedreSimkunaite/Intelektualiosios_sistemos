clear all
clc
%% % Classification using perceptron

% Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

% Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

% Calculate for each image, colour and roundness
% For Apples
% 1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
% 2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
% 3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
% 4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
% 5th apple image(A5)hsv_value_A5=spalva_color(A5); %color
hsv_value_A5=spalva_color(A5); %color
metric_A5=apvalumas_roundness(A5); %roundness
% 6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
% 7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
% 8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
% 9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%4nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

% selecting features(color, roundness, 3 apples and 2 pears)
% Train data: A1,A2,A3,P1,P2

% building matrix 2x5 for training
x1=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2];
x2=[metric_A1 metric_A2 metric_A3 metric_P1 metric_P2];
% estimated features are stored in matrix P:
P=[x1;x2];

% Desired output vector: 1 -> apple; -1 -> pear
T=[1;1;1;-1;-1];

% % TRAINING single perceptron with two inputs and one output

% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);

% calculate weighted sum with randomly generated parameters
e1 = 0;

for i = 1:5
    v1 = P(1, i)*w1 + P(2, i)*w2 + b;
    % calculate current output of the perceptron 
    if v1 > 0
        y = 1;
    else
        y = -1;
    end
    % calculate the error
    e1 = e1 + (T(i) - y);
end

% repeat the same for the rest 4 inputs x1 and x2
% calculate wieghted sum with randomly generated parameters
% calculate current output of the perceptron 
w1_new = w1;
w2_new = w2;
b_new = b;
eta = 10^(-3);
cycle_on = true;
e2 = 0;
    
while cycle_on

    for i = 1:5
        v2 = P(1, i)*w1_new + P(2, i)*w2_new + b_new;
        % calculate current output of the perceptron 
        if v2 > 0
            y = 1;
        else
            y = -1;
        end

        % calculate the error
        w1_new = w1_new + eta*e2*P(1,i);
        w2_new = w2_new + eta*e2*P(2,i);
        b_new = b_new + eta*e2;
    end

    e2 = 0;

    for i = 1:5
        v2 = P(1, i)*w1_new + P(2, i)*w2_new + b_new;
        % calculate current output of the perceptron 
        if v2 > 0
            y = 1;
        else
            y = -1;
        end
        % calculate the error
        e2 = e2 + T(i) - y;
    end
    cycle_on = (e2 ~= 0);
end

% % TEST single perceptron with two inputs and one output

%selecting features(color, roundness, 3 apples and 2 pears)
% Train data: A1,A2,A3,P1,P2
% Test data: A4,A5,A6,P3,P4,A7,A8,A9

% building matrix 2x8 for testing
x1=[hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_P3 hsv_value_P4 hsv_value_A7 hsv_value_A8 hsv_value_A9];
x2=[metric_A4 metric_A5 metric_A6 metric_P3 metric_P4 metric_A7 metric_A8 metric_A9];
% estimated features are stored in matrix P:
P=[x1;x2];

% Desired output vector: 1 -> apple; -1 -> pear
T=[1;1;1;-1;-1;1;1;1];
T_Out = [0;0;0;0;0;0;0;0];
for i = 1:8
    v2 = P(1, i)*w1_new + P(2, i)*w2_new + b_new;
    % calculate current output of the perceptron 
    if v2 > 0
        T_Out(i) = 1;
    else
        T_Out(i) = -1;
    end
end

testing_succsessful = isequal(T, T_Out);

% Isvada: ne visada uztenka duomenu perceptrono apmokymui. Kartais, nepaisant
% to, kad po apmokymu gaunamas perceptrono nulinis error'as, testavimo metu
% su skirtingais duomenimis, perceptronas ne visada tinkamai atskiria
% kriauses nuo obuoliu. T.y.: jeigu testavimo metu testing_succsessful
% gaunamas 0, reikia koda kelis kartus paleisti is naujo. Nes kiekvieno
% kodo paleidimo metu sugeneruojamos vis skirtingos pradines w1, w2 ir b
% reiksmes. 
% Taip pat perceptrono kokybei turi itakos apmokymo zingsnis,
% pvz.: kai apmokymo zingsnis eta = 10^(-3) pakanka keliu kodo paleidimu,
% kad tiek perceptrono apmokymas, tiek testavimas butu sekmingi. O kai
% mokymo zingsnis eta = 10^(-4), nepaisant to, kad perceptrono
% apmokymas sekmingas, perceptrono testavimas buna nesekmingas ir reikia
% daugiau kartu paleisti koda, kad pamokymo ir testavimo rezultatai butu
% sekmingi, palyginus kai eta = 10^(-3).
% Proramuota su MATLAB Online.

%% % Classification using Naive Bayes
% https://medium.com/@balajicena1995/naive-bayes-numerical-example-afcfa2433f95
% https://www.youtube.com/watch?v=O2L2Uv9pdDA

% Apple - round, red/yellow
% Pear - not round, green/brown
 
% % TRAINING
cnt = 3;
color_a = [hsv_value_A1; hsv_value_A2; hsv_value_A3];
color_p = [hsv_value_P1; hsv_value_P2; hsv_value_P3];
color_a_min = min(color_a);
color_a_max = max(color_a);
color_p_min = min(color_p);
color_p_max = max(color_p);
 
round_a = [metric_A1; metric_A2; metric_A3];
round_p = [metric_P1; metric_P2; metric_P3];
round_a_min = min(round_a);
round_a_max = max(round_a);
round_p_min = min(round_p);
round_p_max = max(round_p);

aa_color_f = 0;
ap_color_f = 0;
pp_color_f = 0;
pa_color_f = 0;
aa_round_f = 0;
ap_round_f = 0;
pp_round_f = 0;
pa_round_f = 0;

for i = 1:cnt
 
    % count how many apples by color are in apple and pear color data interval
    if (color_a(i) <= color_a_max && color_a(i) >= color_a_min)
        aa_color_f = aa_color_f + 1;
    end
    if (color_a(i) <= color_p_max && color_p(i) >= color_p_min)
        ap_color_f = ap_color_f + 1;
    end

    % count how many pears by color are in apple and pear color data interval
    if (color_p(i) <= color_a_max && color_a(i) >= color_a_min)
        pa_color_f = pa_color_f + 1;
    end
    if (color_p(i) <= color_p_max && color_p(i) >= color_p_min)
        pp_color_f = pp_color_f + 1;
    end
 
    % count how many apples by roundness are in apple and pear color data interval
    if (round_a(i) <= round_a_max && round_a(i) >= round_a_min)
        aa_round_f = aa_round_f + 1;
    end
    if (round_a(i) <= round_p_max && round_p(i) >= round_p_min)
        ap_round_f = ap_round_f + 1;
    end

    % count how many pears by roundness are in apple and pear color data interval
    if (round_p(i) <= round_a_max && round_a(i) >= round_a_min)
        pa_round_f = pa_round_f + 1;
    end
    if (round_p(i) <= round_p_max && round_p(i) >= round_p_min)
        pp_round_f = pp_round_f + 1;
    end
 
end

a_f = aa_round_f + ap_round_f + aa_color_f + ap_color_f;
p_f = pp_round_f + pa_round_f + pp_color_f + pa_color_f;
 
%                   Pear cnt.   Apple cnt.  
% Apple color       pa_color_f  aa_color_f  
% Pear color        pp_color_f  ap_color_f  
% Apple roundness   pa_round_f  aa_round_f  
% Pear roundness    pp_round_f  ap_round_f  
% Total             p_f         a_f

% P(Apple color|Apple)
PaaC = aa_color_f / a_f;
% P(Pear color|Apple)
PapC = ap_color_f / a_f;
% P(Apple roundness|Apple)
PaaR = aa_round_f / a_f;
% P(Pear roundness|Apple)
PapR = ap_round_f / a_f;

% P(Apple color|Pear)
PpaC = pa_color_f / p_f;
% P(Pear color|Pear)
PppC = pp_color_f / p_f;
% P(Apple roundness|Pear)
PpaR = pa_round_f / p_f;
% P(Pear roundness|Pear)
PppR = pp_round_f / p_f;

% P(Apple)
Pa = a_f/(a_f*p_f);
% P(Pear)
Pp = p_f/(a_f*p_f);

% Apple -> 1, Pear -> -1 
% If Apple color and roundness apple probability ir bigger that apple color and roundness pear
% probability, then apple color and roundness fruit is classified as apple.
% Same is done with Pear color, Pear roundness, Apple roundness.

% Apple color, Apple roundness
AppleCAppleR = -1;
if((Pa*PaaC*PaaR)>(Pp*PpaC*PpaR))
    AppleCAppleR = 1;
end

% Apple color, Pear roundness
AppleCPearR = -1;
if((Pa*PaaC*PapR)>(Pp*PpaC*PppR))
    AppleCAppleR = 1;
end

% Pear color, Apple roundness
PearCAppleR = -1;
if((Pa*PapC*PaaR)>(Pp*PppC*PpaR))
    AppleCAppleR = 1;
end

% Pear color, Pear roundness
PearCPearR = -1;
if((Pa*PapC*PapR)>(Pp*PppC*PppR))
    AppleCAppleR = 1;
end

% Output shows that:
% apple color fruits and fruits with apple roundness are classified apples,
% apple color fruits and fruits with pear roundness are classified pears,
% pear color fruits and fruits with pear roundness are classified pears,
% pear color fruits and fruits with apple roundness are classified pears.

% % TESTING
cnt = 7;
test_color = [hsv_value_A4; hsv_value_A5; hsv_value_A6; hsv_value_P4; hsv_value_A6; hsv_value_A7; hsv_value_A8; hsv_value_A9];
test_round = [metric_A4; metric_A5; metric_A6; metric_P4; metric_A7; metric_A8; metric_A9];
TNB = [1;1;1;-1;1;1;1];
T_OutNB = [0;0;0;0;0;0;0];

% apple -> 1, pear -> -1
color = 0;
round = 0;

for i = 1:cnt
 
    if (test_color(i) <= color_a_max && test_color(i) >= color_a_min)
        color = 1;
    end
    if (test_color(i) <= color_p_max && test_color(i) >= color_p_min)
        color = -1;
    end

    if (test_round(i) <= round_a_max && test_round(i) >= round_a_min)
        round = 1;
    end
    if (test_round(i) <= round_p_max && test_round(i) >= round_p_min)
        round = -1;
    end
    
    T_OutNB(i) = -1;
    if((color == 1)&&(round == 1))
        T_OutNB(i) = 1;
    end
    % if((color == -1)&&(round == 1)) / if((color == 1)&&(round == -1))
    % if((color == -1)&&(round == -1)) -> -1
end

% Isvada: nepaisant to, kad Naive Bayes klasifikatoriaus veikimo principas 
% aprasytas tinkamai, taciau, kadangi klasifitoriui buvo naudojamas per siauras
% duomenu kiekis ir ribotos salygos, testavimo metu ne visi duomenys buvo
% suklasifikuoti teisingai.
% Proramuota su MATLAB Online.
