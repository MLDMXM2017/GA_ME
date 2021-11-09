%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  This script uses features obtained by STSTNET and genetic algorithm to realize microexpression recognition.
%  Reference:
%  xxxxxxxx
%
%  The files include:
%  1) GA_libsvm.m : Script which trains results of 68 groups (LOSO) with GA 
%  2) crosspop.m : The crossover process of GA's chromosome
%  3) variation.m : The mutation process of GA's chromosome
%  4) judgepop.m : Determine whether the elemental difference between the two chromosomes is greater than the mutation rate
%  5) select_libsvm.m : The selected features are classified through the classifier
%  6) input : Input data features (442*400) extracted from STSTNet
%
%  Matlab version was written by Jin Qiushi and was tested on Matlab 2019b
%  If you have any problem, please feel free to contact Sze Teng Liong (stliong@fcu.edu.tw)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc,clear;

load('ststnet_num.mat');
population_size=50; % Population quantity
d=150;% Evolution algebra
chr_length=400;% Chromosome length
change_rate=0.8;% Crossover probability
Accuracy=[];
tempac=0;
disp("libsvm start!!");

for fold=1:68
    pop=round(rand(population_size,chr_length));%Random generation of primary chromosomes 0/1  
    i=1;
    while i<=d
        b=variation(pop); % mutation process
        %new species
        if ~isempty(b)
            new_pop=[pop;crosspop(pop,change_rate);b];  
        else
            new_pop=[pop;crosspop(pop,change_rate)];
        end
        [AC,next_pop]=select_libsvm(new_pop,testnum,fold);  
        Accuracy=[Accuracy;[1000,1000];AC];
        pop=next_pop(1:population_size,:);   %Pick the next generation with the same size as the original
    
        if i==1 %generation=1
            need_pop=next_pop(1:population_size,:); %need_pop:The entire population left behind by each generation
            need_pop2=next_pop(1,:); %need_pop2:The optimal set of chromosomes for each generation
        else
            need_pop=cat(1,need_pop,next_pop(1:population_size,:));
            need_pop2=cat(1,need_pop2,next_pop(1,:));
        end
        i=i+1;
    end
    save(['pop/',num2str(fold),'.mat'],'need_pop2');% 1.mat : Stored the first person 150 generations of each of the optimal individuals
    % The features selected from the last generation of chromosomes are used as train_value to train the classifier.
    % Then the unknown data is put into the prediction to obtain the PREDICT_LABEL
    people= testnum(:,chr_length+2);
    predictors = testnum(:, 1:chr_length);
    response = testnum(:,chr_length+1);
    
    % original train and test features
    ti=1;
    temp=0;
    temp1=0;
    while ti<443
        if people(ti)==fold
               if temp==0
                    orign_test_label=response(ti);
                    orign_test_value=predictors(ti,:);
                    temp=1;
                else
                    test_label_temp=response(ti);
                    orign_test_label=cat(1,orign_test_label,test_label_temp);
                    test_value_temp=predictors(ti,:);
                    orign_test_value=cat(1,orign_test_value,test_value_temp);
               end
        else
            if temp1==0
                    orign_train_label=response(ti);
                    orign_train_value=predictors(ti,:);
                    temp1=1;
                else
                    train_label_temp=response(ti);
                    orign_train_label=cat(1,orign_train_label,train_label_temp);
                    train_value_temp=predictors(ti,:);
                    orign_train_value=cat(1,orign_train_value,train_value_temp);
            end
        end
        ti=ti+1;
    end
    
    % pick festures
    [d,w]=size(need_pop2);
    if sum(need_pop2(d,:))~=0
        cho=0;
        for j=1:w
            if need_pop2(d,j)==1
                cho=cho+1;
                if cho==1
                    fold_train_value=orign_train_value(:,j);
                    fold_test_value=orign_test_value(:,j);
                else
                    fold_train_value=cat(2,fold_train_value,orign_train_value(:,j));
                    fold_test_value=cat(2,fold_test_value,orign_test_value(:,j));
                end
            end
        end
    end

    classifier = libsvmtrain(orign_train_label,fold_train_value, '-s 0 -t 2 -c 2');
    [predict_label,~,~] = libsvmpredict(orign_test_label,fold_test_value, classifier);

    if fold==1
        predict_total_label=predict_label;
    else
        predict_total_label=cat(1,predict_total_label,predict_label);
    end
    
end
save('label/pre.mat','predict_total_label');