% The selected features are classified through the classifier
function[AC,newpop]=select_libsvm(pop,testnum,f)
[d,w]=size(pop);
people= testnum(:,402);
predictors = testnum(:, 1:400);
response = testnum(:,401);
AC=zeros(d,2);


for i=1:d
    if sum(pop(i,:))~=0
        cho=0;
        for j=1:w
            if pop(i,j)==1
                cho=cho+1;
                if cho==1
                    temp_value=predictors(:,j);
                else
                    temp_value=cat(2,temp_value,predictors(:,j));
                end
            end
        end
        
        temp_num=0;
        fold=f; 
        ti=1;
        temp=0;
        temp1=0;
        last_num=temp_num;
        while ti<443
            if people(ti)==fold
                temp_num= temp_num+1;
                if temp==0
                    test_label=response(ti);
                    test_value=temp_value(ti,:);
                    temp=1;
                else
                    test_label_temp=response(ti);
                    test_label=cat(1,test_label,test_label_temp);
                    test_value_temp=temp_value(ti,:);
                    test_value=cat(1,test_value,test_value_temp);
                end
            else
                if temp1==0
                    train_label=response(ti);
                    train_value=temp_value(ti,:);
                    temp1=1;
                else
                    train_label_temp=response(ti);
                    train_label=cat(1,train_label,train_label_temp);
                    train_value_temp=temp_value(ti,:);
                    train_value=cat(1,train_value,train_value_temp);
                end
            end
            ti=ti+1;
        end
        
        %LibSVM classifier & Five fold cross validation
        k =5;
        sum_accuracy_svm = 0;
        [m,~] = size(train_value);
        indices = crossvalind('Kfold',m,k);
        for j = 1:k
            test_indic = (indices == j);
            train_indic = ~test_indic;
            train_datas = train_value(train_indic,:);
            train_labels = train_label(train_indic,:);
            test_datas = train_value(test_indic,:);
            test_labels = train_label(test_indic,:);
            % 开始LibSVM分类器多分类训练
            model = libsvmtrain(train_labels,train_datas,'-s 0 -t 2 -c 2');
            [predict_label,~,~]  = libsvmpredict(test_labels, test_datas,model);
            accuracy_svm = length(find(predict_label == test_labels))/length(test_labels);
            sum_accuracy_svm = sum_accuracy_svm + accuracy_svm;
        end 
        mean_accuracy_svm = sum_accuracy_svm / k;
   
        AC(i,:)=[mean_accuracy_svm,i];
    else
        AC(i,:)=[0,i];
    end
    
end

AC=sortrows(AC,1,'descend');

for i=1:d
    if i==1
        newpop=pop(AC(i,2),:);
    else
        newpop=cat(1,newpop,pop(AC(i,2),:));
    end
end

end