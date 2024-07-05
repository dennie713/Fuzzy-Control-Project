clc
clear
close all

%% create samples:
for i=1:100  
     x1(i) = rand()*5;
    y1(i) = rand()*5;    
    x2(i) = rand()*5 + 3;
    y2(i) = rand()*5 + 3;
end  
x = [x1,x2];  
y = [y1,y2];  
data = [x;y];
data = data';

figure
plot(data(:,1),data(:,2),'k*');

%% ---
cluster_n = 2; %類別數量
iter = 100; % 疊代停止次數
m = 2; % fuzzier

num_data = size(data,1);%樣本個數
num_d = size(data,2);%樣本維度

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
        
        c(j,:) = u_ij_m*data./sum_u_ij;
    end
    
    % 更新 uij
    for j = 1:cluster_n
        for k = 1:num_data
            sum1 = 0;
            for j1 = 1:cluster_n
                temp = (norm(data(k,:)-c(j,:))/norm(data(k,:)-c(j1,:))).^(2/(m-1));
                sum1 = sum1 + temp;
            end
            U(j,k) = 1./sum1;
        end
    end
    
    % 計算目標函數 J
    temp1 = zeros(cluster_n,num_data);
    for j = 1:cluster_n
        for k = 1:num_data
            temp1(j,k) = U(j,k)^m*(norm(data(k,:)-c(j,:)))^2;
        end
    end
    J(i) = sum(sum(temp1));    
    
end

%% 繪圖
figure;
plot(J);

figure
hold on
[~,label] = max(U); % 找到所屬的類
gscatter(data(:,1),data(:,2),label)
plot(c(:,1),c(:,2),'kd')