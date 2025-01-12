clc;clear;close all;

% Fuzzy C-Means Clustering 

%%read data
[DataSet,txt] = importdata('Data_User_Modeling_Dataset_Hamdi Tolga KAHRAMAN.xls') ;
DataSet_Train = DataSet;

%% ---
cluster_n = 4; %類別數量
iter = 200; % 疊代停止次數
% prompt = "input m  ";
% m = input(prompt);
m = 2; % fuzzier

num_data = size(DataSet_Train.data.Training_Data,1);%樣本個數
num_d = size(DataSet_Train.data.Training_Data,2);%樣本維度

% --初始化隸屬值uij，且含限制條件
U = rand(cluster_n,num_data);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n,1),:);

%%
for i = 1:iter
    % 更新 Ci
    for j = 1:cluster_n
        u_ij_m = U(j,:).^m;
        sum_u_ij = sum(u_ij_m);
        
        c(j,:) = u_ij_m*DataSet_Train.data.Training_Data./sum_u_ij;
    end
    
    % 更新 uij
    for j = 1:cluster_n
        for k = 1:num_data
            sum1 = 0;
            for j1 = 1:cluster_n
                temp = (norm(DataSet_Train.data.Training_Data(k,:)-c(j,:))/norm(DataSet_Train.data.Training_Data(k,:)-c(j1,:))).^(2/(m-1));
                sum1 = sum1 + temp;
            end
            U(j,k) = 1./sum1;
        end
    end
    
    % 計算目標函數 J
    temp1 = zeros(cluster_n,num_data);
    for j = 1:cluster_n
        for k = 1:num_data
            temp1(j,k) = U(j,k)^m*(norm(DataSet_Train.data.Training_Data(k,:)-c(j,:)))^2;
        end
    end
    J(i) = sum(sum(temp1));    
    
end
[~,label] = max(U); % 找到所屬的類
stat = tabulate(label) ;
%%讀種類的代表的數字
for i = 2:259
    data(i) = DataSet_Train.textdata.Training_Data(i,6);
    if data(i) == "very_low"
        num1(i-1,1) = label(i-1);
    elseif data(i) == "High"
        num2(i-1,1) = label(i-1);
    elseif data(i) == "Low"
        num3(i-1,1) = label(i-1);
    elseif data(i) == "Middle"
        num4(i-1,1) = label(i-1);
    end
end

stat_1 = tabulate(num1) ;
stat_2 = tabulate(num2) ;
stat_3 = tabulate(num3) ;
stat_4 = tabulate(num4) ;

for i = 1:size(stat_1,1)
    if stat_1(i,2)==22 | stat_1(i,2)==22
       a = stat_1(i,1);
    end
end
for i = 1:size(stat_2,1) 
    if stat_2(i,2)==29 | stat_2(i,2)==28
       b = stat_2(i,1);
    end
end
for i = 1:size(stat_3,1)    
    if stat_3(i,2)==32 | stat_3(i,2)==31
       c = stat_3(i,1);
    end
end
for i = 1:size(stat_4,1)    
    if stat_4(i,2)==37 | stat_4(i,2)==36
       d = stat_4(i,1);
    end
end
          
%%分群
% for i = 1:4
%     if stat(i,2)==59
%         a = stat(i,1);
%     elseif stat(i,2)==60
%         b = stat(i,1);
%     elseif stat(i,2)==69
%         c = stat(i,1);
%     elseif stat(i,2)==70
%         d = stat(i,1);
%     end
% end
% num = [a b c d];

%%取代分群為數字
data = DataSet_Train.textdata.Training_Data(2:259,6);
new = replace(data,"very_low",num2str(a));
new = replace(new,"High",num2str(b));
new = replace(new,"Low",num2str(c));
new = replace(new,"Middle",num2str(d));
%cell2metrix
    for i = 1:258
        m(i) = str2num(cell2mat(new(i))); 
    end
%計算成功次數
    count = 0;
    for i = 1:258
        if label(i) == m(i) %比較數據是否相同
            count=count+1;
        end
    end
success_rate = count*100/258;
success_rate
