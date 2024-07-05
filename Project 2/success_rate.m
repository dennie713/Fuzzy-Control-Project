clc;clear;close all;

[DataSet,txt] = importdata('Data_User_Modeling_Dataset_Hamdi Tolga KAHRAMAN.xls') ;
DataSet_Train = DataSet;
load("label.mat");
data = DataSet_Train.textdata.Training_Data(2:259,6);
new = replace(data,"very_low","3");
new = replace(new,"High","2");
new = replace(new,"Low","4");
new = replace(new,"Middle","1");

for i = 1:258
   b(i) = str2num(cell2mat(new(i))); 
end
count = 0;
for i = 1:258
    if label(1,i) == b(1,i)
        count=count+1;
    end
end
success = count*100/258

