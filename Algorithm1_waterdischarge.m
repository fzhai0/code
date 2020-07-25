
%------------------------------------------------------------------------------------------------|
%                         Water Discharge Problem: Algorithm 1                     
%     This algorithm provide a method to obtain the best parameters fit the BPNN and the database
%             The NN serves as a prediction for the Water Emptying Time              
%     PAST2501: Fluid Mechanics online reseacch program, Dr. Reza Alam. 2020
%                          Written and Editted by Hanfeng Zhai
%------------------------------------------------------------------------------------------------|


R_value = 0; % preset the sum of determine factor R^2
e = 0; % preset the sum of relative error epsilon

for i = 1:1e3 % run a loop to calculate the mean of R^2, epsilon, and t_run
    i = i + 1;
    

%% I. pre-operation
close all
clc

%% II. training & testing set
%%
% 1. import data
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

%% III. normalize the data
[p_train, ps_input] = mapminmax(P_train,0,1);
p_test = mapminmax('apply',P_test,ps_input);

[t_train, ps_output] = mapminmax(T_train,0,1);

%% IV. train the BPNN
%%
% 1. generate the NN
net = newff(p_train,t_train,6);
% change the neuron No. Ksi from 1 --> 20

%%
% 2. training parameters
net.trainParam.epochs = 1e5;
net.trainParam.goal = 1e-3;

net.trainParam.lr = 1e-3;
% change the learning rate Alpha from 10^-1 --> 10^-5

%%
% 3. training the net
net = train(net,p_train,t_train);

%%
% 4. simulation test
t_sim = sim(net,p_test);

%%
% 5. reverse the normalization
T_sim = mapminmax('reverse',t_sim,ps_output);

%% V. function analysis
%%
% 1. relative error
error = abs(T_sim - T_test)./T_test;

%%
% 2. decision parameter R^2
R2 = (N.* sum(T_sim.* T_test) - sum(T_sim).* sum(T_test)).^2 / ((N.* sum((T_sim).^2) - (sum(T_sim)).^2).* (N.* sum((T_test).^2) - (sum(T_test)).^2)); 

%%
% 3. results obtain
result = [T_test' T_sim' error'];

%% VI. Caculate the sum
R_value = R_value + R2;
e = e + error;

R2_mean = R_value./i;
e_mean = e./i;

t_1 = cputime; %calculate the running time t_run
%%
end