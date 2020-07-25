
%------------------------------------------------------------------------------------------|
%                         Water Discharge Problem: Algorithm 2                     
%     This algorithm provide a method to obtain the satisfied NN through running a loop
%             The NN serves as a prediction for the Water Emptying Time              
%     PAST2501: Fluid Mechanics online reseacch program, Dr. Reza Alam. 2020
%                          Written and Editted by Hanfeng Zhai
%------------------------------------------------------------------------------------------|

for i = 1:1e5 % run a large loop to detect the obtained NN
    i = i + 1;
    

%% I. pre-operation
close all
clear all
clc
% clear all the data to eliminate the influence of the preceding step 

%% II. training & testing set
%%
% 1. import data (water discharge data)
load waterdischarge.mat

S1 = 1;

%%
% 2. generate the training and testing data 
X = waterdischarge(:,1:6);
y = waterdischarge(:,7);
temp = randperm(size(X,1));
% training set with 6 samples
P_train = X(temp(1:6),:)';
T_train = y(temp(1:6),:)';
% testing set with 6 samples
P_test = X(temp(7:end),:)';
T_test = y(temp(7:end),:)';
N = size(P_test,2);

%% III. normalization
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);

[t_train, ps_output] = mapminmax(T_train,0,1);

%% IV. train the BPNN
%%
% 1. generate the NN
net = newff(minmax(p_train),[S1,1],{'tansig','purelin'},'trainlm'); % neuron Ksi = 1, obtained through Algorithm 1

%%
% 2. training parameters
net.trainParam.epochs = 1e5;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 1e-3;% learning rate Alpha = 10^-3, obtained through Algorithm 1

%%
% 3. training the net
net = train(net,p_train,t_train);

%%
% 4. simulation test
t_sim = sim(net,p_test);

%%
% 5. reverse the normalization --> obatain the original scaled data
T_sim = mapminmax('reverse',t_sim,ps_output);

%% V. Function analysis
%%
% 1. calculate the relative error
error = abs(T_sim - T_test)./T_test;

%%
% 2. calculate the decision parameter R^2
R2 = (N.* sum(T_sim.* T_test) - sum(T_sim).* sum(T_test)).^2 / ((N.* sum((T_sim).^2) - (sum(T_sim)).^2).* (N.* sum((T_test).^2) - (sum(T_test)).^2)); 

%%
% 3. results obtain
result = [T_test' T_sim' error'];

%% VI. generate the graphs
figure
plot(1:N,T_test,'b:*',1:N,T_sim,'r-o')
legend('Real','Predict')
xlabel('Predicted samples')
ylabel('Noise values')
string = {'Comparison';['R^2=' num2str(R2)]};
title(string)

%% VII. generate a condition to break the loop
% ( if a satiated NN is obtained )
if R2 > 0.95
    figure(2)
    plot(error)
    break
end
%%
end